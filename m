Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D595F615CBD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 08:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiKBHLj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 03:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKBHLh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:11:37 -0400
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE0513F46;
        Wed,  2 Nov 2022 00:11:34 -0700 (PDT)
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A22tocf015311;
        Wed, 2 Nov 2022 07:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=TbbGjevsy6E7Le4eHSc9KDgBNBKS2nrGxp8Yqruljuc=;
 b=ZbSxFaLutWpOZ+p/9BH2u/vBllcJ33WgdFg4AuAhJykCTvjfKfNp9f+UTk2M5xeF85tb
 JAdtIG9OJw2zXhfromnhqKcNwwRn/ANJrfaRJHMd34pZpJAaEr/W7GVJF8tTeBGkuZuk
 FwtlcWgKpsiEa9YyUEdYEQ44gc65RTl0nV49hCR35NgctvHf+FyY2CYGcpEoJwtpXsCd
 mXZPuQ88X76HptmFoOhjMxLxlkrKlLykI3x0tWzPv4+aZzzZ/gKN2IKaHipyT96w0+OC
 dxl2kkZGVkouIsVgykR3FeJ12qbttKfH1IOQvW366HEJdJPi+bDTKKjGrjU7/KaFqvx7 8w== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2044.outbound.protection.outlook.com [104.47.26.44])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3kjhf8j0dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 07:11:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Obgaqu90WaHAETPYV8D8rIjen0GFh/qkARgUrJ1fyZUyUvB2Hw+Pu6KwnoE90Wtsbsoa5fNgSXYRaXdqXEpD78TKcRe99YmVbSZ/aQcKI8dSk4uGmeeh3id3liYrpkRpExbvOjT7WrGeaox/4Et6TH1n04LfIt7t/68NSRybd0hOoQVXucuMIccgViTcXzaCLd7OQUS8m4CliXZRZy71axpAWCw+/DKpEvB5AVMlo40tlTjRCTlT19FLZQJRHwSU377x5J9jyzHDlrnFWE5pA2v5jXlm9f+3p7LP2Hi6kHwb8FpDPz28zPVH0iWo1ij0tJ/sRfe72WYCWwDcwSJ0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbbGjevsy6E7Le4eHSc9KDgBNBKS2nrGxp8Yqruljuc=;
 b=F5mW5F14vbr1pgM17hGOoV5BFz7Y7CLo/CA5yucXgeHrlUFWSormwhqjqlkrO10N1epaWH771Zs2yHCpu4mD9KffJieWBnMHKmcqNN46c1EqV2qO4CtW2AxY9nLYAEDaHcX6KdEwta67U3MBjB008Q7Osi2o40ZK9+BY9bnCKrbTzv5sQEyZ1UDNupHcuXY2wnjIpmXsSUZuLf534dCMw8I5WESH2eSS6zwgImEerjYSoO9wcC72YNsBZfkP+e99Hd+qwL4SbTFozayQIB0vOErxqyrtKGouA0MlvShTopbhvczPfl4nW7lhg2A/s+uHPhAY584/VCaDL+o4hE0Qfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR0401MB6242.apcprd04.prod.outlook.com (2603:1096:820:c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 07:11:16 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222%9]) with mapi id 15.20.5769.015; Wed, 2 Nov 2022
 07:11:15 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 0/2] optimize empty entry hint
Thread-Topic: [PATCH v2 0/2] optimize empty entry hint
Thread-Index: AdjuiUXNLuMWGiBIStW1pttk/BAKbw==
Date:   Wed, 2 Nov 2022 07:11:15 +0000
Message-ID: <PUZPR04MB63164ACED51074ACFA332BC181399@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR0401MB6242:EE_
x-ms-office365-filtering-correlation-id: 647f8e82-a239-45ff-4639-08dabca16eac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k2l+JjHMs8rWuEBKLbggnphgC8o6X8qC6aVQhS7bOXkTjQr94ZnZ5Mbp9VTYCMEc9Hpw6QjrcI9b+eLS2OyMKGfxJzVPNyzsGDzHDB2w1Ok5qEcbWwMyatBzlhyxV5UPJOYeK0wVeWXRycXevPWxcznft3jxU4JX/+BCEm2UfWDziZxMSJhNhpK3Fxw074GmFNDqYY10tH4GooDcroJiKaIYm4+9NQ4/wrcpElNH7yHj3wL3xQ0usDPy6+72thk/ff33QccgUS0RD5vJ9BpMMqprIgXk7cgdGr8d5rBG3SFWwKFq3c8u0BMdiV3PpaJp2MrqtRuVBLoOj2zJPJpNuNB0FzbpllwCHdY35hvyO23+oN9uwPhtneJZv28ZhBQBeB47ux4kfw6uzvjLNLwYFdBu9GeSTzDAhzPy8xF8FgEIezrw2Fa6aUDXBegb42RyKQQ9KfT8HaMFdW6bHNXp1tSip3c+GVo2wJnIZJC0BUoatun1gGSJubu+FO30hP0CSW3byVs/7O5Fd5yWGdx+JmC57q9DEhsSjc1a6/8BQV4GEvKHvHXNGmz75WA/dHVXUbfz5AZLelxIxl/egxoTtc8K/GvKXZYjmiIvg7IgQ6VRkbQCjKiZkKqxdSGwvQq6jQ221QwQbX6uy6rwIsJ5TLgX1Ss8tqNgK/sXFlf0qvqNlBMhrgtpTyyMQLf0FV2uINEbubdnjyaStObwGlXKsTl5UE1+fpd9Y8JlFQcAQT92OwCRe26Vxukeh6btbjAgWYJyybmGSa/iqpQzC80XUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199015)(9686003)(6506007)(186003)(107886003)(316002)(26005)(2906002)(83380400001)(4744005)(7696005)(55016003)(54906003)(66476007)(478600001)(66446008)(41300700001)(5660300002)(64756008)(76116006)(71200400001)(8936002)(66946007)(4326008)(8676002)(66556008)(52536014)(110136005)(86362001)(33656002)(122000001)(82960400001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0pYTzlFQkZzOGUzL3NGendQS2VxM3pBaFV4bFdMQVdMZkc3MUtWUmo4a1NZ?=
 =?utf-8?B?YjlkdzRtSWdVWCtwN0h4Y3R4d3F4enBVR2JHekZnUGpDbk9zUm10cWxBNWRr?=
 =?utf-8?B?UWsxSHdHMDBrVHJ0S05ud1E2bjczN3VhaVNCczBseVFrTzlOOW5iOE5yQlV6?=
 =?utf-8?B?K2toZ3pWeCsxSFdoMFJqcytwTTc4cUI3VzIrL2owZzZYZ1U0Y05JcGhEQjRK?=
 =?utf-8?B?cWRYZW5zbnlFUHFnWHpEUll4N2dKWnpjMzlabFBWbXUzUlRKZXB6K1J4RDBq?=
 =?utf-8?B?MVF0UmgvRzlTd3VnaHpSOXBPOC95SVhEZFdXWFpaMmhTbm9GemZFbTRpRG5v?=
 =?utf-8?B?U2gzZkg3WEY0UnFScmZidDcwVm9sQ1VwRTRUWUtia2RSVVZuWHJJUmVHS1NM?=
 =?utf-8?B?ZmdodVhvMUswbmE0eEZENXlsZDZzN2Z0UW5xcGJiVlJqMktEQlpBR2h3LzRS?=
 =?utf-8?B?UkRzTG1jSW9CYkFYZkFWQVl5WVNVMEtGNkhQOEZLRmFHaGhVTjU5TkRTdmtR?=
 =?utf-8?B?VWZ5OHkzck9tV2lZdm1zb2dsZEp3UHQrazNma0xYRUYvd1VHRm1uWmU0cGV6?=
 =?utf-8?B?Rk5WTlNXNk1DTWJOWWNMNVV0b0VaL1FRbWdWUmMvblRzcEIwaC94RnpMTmxv?=
 =?utf-8?B?dVpWNFIyd1FyT3ZFKzVmNndrVTFXTDVBSFRzRmdJMjZmbzExeStiTHIrVHdO?=
 =?utf-8?B?RTJ1U0NJdzNYZ0pNQUxHWWpMRERGSGM5RzNSbDFDNHVob1FpMVdWeWdad0li?=
 =?utf-8?B?bUJ0UjFldkVyNVdMUDBTcnBHa2R0NUZZYTlDZjdZcXV6R2ZaaTkyQVBiSVVO?=
 =?utf-8?B?SE0vc1pkRU5iRkN4SE0wazBiV0RwcFBWYU9BTzBLV29aQ1RpTWxOWFI5Qk5G?=
 =?utf-8?B?L0JlYmV6d2g3bFZmOVUyZ0R2T2Y4YXFmeUxXdjlhZTBqWDljYU5GaU1WdDdv?=
 =?utf-8?B?UXFLTTY0Q2l2bUdnMllOYlloV1lBL3NiVVk3YlE0NjNNeFBVUjhNUkpNZEZC?=
 =?utf-8?B?WHVNREFYRDRHQmtrYmcxWW1kWjBReXAvUkszNWZ3a1JCMk9DbGNsM25qSThi?=
 =?utf-8?B?bFVEd3Z5T0lCYzBkbENnU3N0ZEtNeXBLWWZWUkJnTDQ3UVdIVU55WStETVlD?=
 =?utf-8?B?UjJSMTA2b05ESG5oVlpjUWgwb1k2dHVwN0U1aEVWT2E4Y2lvaC9FRWIyVTZZ?=
 =?utf-8?B?T3pCYkVSTkp6ZWpGWnpRQ0x4bzRUKzBEVkhqOFF6MWRZTlFGRVZrVGw2NDRP?=
 =?utf-8?B?Z3pwL1I1T2JVZGdyYjhIMDBwemVTN0s5OU5iWjJMR0xMMzlTYkZMd1BsVEhp?=
 =?utf-8?B?WVFERzVodG5uL2FHb0N3dllzcDUrTmxpaUlaSXVFdkEzY1VLeUlENEU5dDRY?=
 =?utf-8?B?QTE2M2cyTEZqWnhIZUVYZHAzanBudUY2bEdock0yRnJ4RWNXVU0yMlVvR2M5?=
 =?utf-8?B?K003Zk1nbDdSNVFQbldmRVBielMxVnorWkdXZWZIVHFEWkc1YlhLbGNjc09v?=
 =?utf-8?B?cEVnVnRTSkpiSGVRcVNURU0zazdIYytNODlLWHBRR25icHkzdEZObEI3dUpZ?=
 =?utf-8?B?d1JwQjJ6VnVMVy93Lzgxc3dJQUVpVFIxWVd6bmZSK21mMUpPYVdXcVdWZ3ZM?=
 =?utf-8?B?a3loWGREYUNqc0k0WFFSRjdJOEdVZUVEaTJ1TzVSR09MVjFoTWlUQUdMZEk3?=
 =?utf-8?B?UHNiZHJleHAyazdKdXVpdVBSYlhkZ1FnUnpTNDFHRVdlMExkOUFuNTF6UXhp?=
 =?utf-8?B?RUVRbXFGQ3Rjd0h0dXdVdDNyL0JmYTJzSTVLVlhNRjIrTHZOMVJRcjBkK2R5?=
 =?utf-8?B?QWE1YVIwY0k0MXFiY1NIN1VDTXhiaVRwdkhkUkRkckxKNW5nS0R1SzZyVzdW?=
 =?utf-8?B?Z3FKV0tyZG5BZWZxdmkxeEYreU5ucjQ1TFEvZTFFV0gvMHdtS3NTbmxScHNo?=
 =?utf-8?B?aGp1cFp2WkkwTzJmMjlvekxZOWdmNXd1eWhsQU0vUVFYUm5BZmxBUWpuTjVT?=
 =?utf-8?B?cWZvQ2RFMVNwOFBYc01UNFpzL0VqYnZLV3RzaGlJN1pFWFlqMGtQcVc4Y2J3?=
 =?utf-8?B?YkZhdVUyRWtyNldURDN5VDBaeWwzMWw3VllIZGFidWFOLzE2Nzc1RnRrM1Vl?=
 =?utf-8?Q?u8Ds/3RWzqXQVYC8wqWc9t2bc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647f8e82-a239-45ff-4639-08dabca16eac
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 07:11:15.8574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Llu1Y4V3JxGRKmupGHLI+O0PBTdiU2M8hyytEg1uwf6ymbgj5C07a5lMMVVBwtb7b/9n75RfPI62RAAe5SZyBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6242
X-Proofpoint-ORIG-GUID: ronkLzy1yHEegpabRAZ768ZdAmygW3L0
X-Proofpoint-GUID: ronkLzy1yHEegpabRAZ768ZdAmygW3L0
X-Sony-Outbound-GUID: ronkLzy1yHEegpabRAZ768ZdAmygW3L0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_04,2022-11-01_02,2022-06-22_01
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhlc2UgY29tbWl0cyByZWR1Y2UgdGhlIG51bWJlciBvZiBkaXJlY3RvcnkgZW50cmllcyB0cmF2
ZXJzZWQgYnkNCm9wdGltaXppbmcgZW1wdHkgZW50cnkgaGludC4NCg0KQ2hhbmdlcyBmb3IgdjI6
DQogIC0gWzEvMl0NCiAgICAtIGFkZCBleGZhdF9yZXNldF9lbXB0eV9oaW50KCkNCiAgICAtIHJl
bmFtZSBleGZhdF9oaW50X2VtcHR5X2VudHJ5KCkgdG8gZXhmYXRfc2V0X2VtcHR5X2hpbnQoKQ0K
ICAgIC0gcmVtb3ZlIHRoZSBjb25kaXRpb24gYGVpLT5oaW50X2ZlbXAuY291bnQgPCBudW1fZW50
cmllc2ANCiAgLSBbMi8yXQ0KICAgIC0gQ2hlY2sgdGhlIGVtcHR5IGVudHJpZXMgYWZ0ZXIgdW51
c2VkIGVudHJ5IGluDQogICAgICBleGZhdF9zZWFyY2hfZW1wdHlfc2xvdCgpDQoNCll1ZXpoYW5n
IE1vICgyKToNCiAgZXhmYXQ6IHNpbXBsaWZ5IGVtcHR5IGVudHJ5IGhpbnQNCiAgZXhmYXQ6IGhp
bnQgdGhlIGVtcHR5IGVudHJ5IHdoaWNoIGF0IHRoZSBlbmQgb2YgY2x1c3RlciBjaGFpbg0KDQog
ZnMvZXhmYXQvZGlyLmMgICB8IDc2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLQ0KIGZzL2V4ZmF0L25hbWVpLmMgfCAzMyArKysrKysrKysrKysrLS0tLS0t
LS0NCiAyIGZpbGVzIGNoYW5nZWQsIDcwIGluc2VydGlvbnMoKyksIDM5IGRlbGV0aW9ucygtKQ0K
DQotLSANCjIuMjUuMQ0K
