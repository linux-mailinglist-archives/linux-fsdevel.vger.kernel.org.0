Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3745BA37F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 02:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiIPA1C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 20:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIPA1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 20:27:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B0858B41
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 17:27:00 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FNmsm4010516;
        Fri, 16 Sep 2022 00:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=iKQWagxlUr0hI7CEXs8uG8L4Gf/e14bUMtNICrWS7zI=;
 b=JUGzmwNp65Y4WNAk7z60ET+GGT0K3ndMyGJHSfQXqT7u/DOScCSEz0O6rpJEIYTxLLmQ
 dSdin0zp/szkRdOMnTp5jzvq7lOUo0z4Em97uHwT1Y2q/G09YsbfWp53szinyraf1rzu
 eRr24c0TfS4OdD44X0Y4QMoQBFrbw4wCb0OhqwHIiw7auHoqSW3iuwxWOz8EqMeB7rfD
 CSw7Sz22I6EwmgiS8FWQNFogvSt5QCDO9xkEWtUU4Zte2I94M0HDljZaax1vnCwYe/sv
 VEb/V5mlCp/DyT24GbChNREV1OOiotij26ZQgoWBGb5BR/tPl0cfcBf0V0Niyn16sdjw TA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8xagtxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 00:26:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28FL8ZXg040221;
        Fri, 16 Sep 2022 00:26:34 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8x6kn85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 00:26:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAUe+D5aCvdRAXD0BQ0nfyySbAFLxXlinl8z98wjF4sXtaF/TjPf/37zHFoXndrr/QDPvPLqslmiuht0R+HnUcwsIXXLov88p7Qiomd3Nga4I2wNmYjDg71aGOcyNF8IB4/eZt2Nyvybsa+FY+6GYdxB/frw2GgfYx8ZrLYutPRLIyyZVbl/OzfIkaSqmlRsCkZyDP56sW6tIhkkvMTwQ+Tt2SN1xrojWHjatb8B7DDWiyrn0w0FeSLNIzQhoW6mnJaR2huJstDWzttUoM7VQwHu2Mnrh1/kIFnWbYziRVbXLozO+i6t0wD/Zg3lR4aK5PeJmUGp42MWkwLUjuv4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKQWagxlUr0hI7CEXs8uG8L4Gf/e14bUMtNICrWS7zI=;
 b=cag9dF3dAq9blTXR2TAhsyr/WBbPRRvjSHaX2AwI4qaRHZFm/FUqi3MJ3PI775W6TByLff8td5BtvS34YbV0wZIQg8RD/XTS38o1duZZu2wwp8O3RpL96zpmUTcanUS2ce1ScAjqCMGi0zAdIcL7/++J81enj1iukVRMa4ivIAjwpDyAbod2Qh/N9bOg2EwIywLEcSfxxOWkMMh2B+vzasSWh63KmL07wL79dkFwC20VQkpDN8PErps+fw5a6bVKrVR8N2ciosDPFjBnJMAQT2D3dYGQKHnN4N97j8nrPiMSqjMcWSHx/gaxKkzVhtcpPFtdCTsLV160IqYtYPQjZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKQWagxlUr0hI7CEXs8uG8L4Gf/e14bUMtNICrWS7zI=;
 b=T3XinOVnlZPU+06FwnMedJFqmS+8AUOLq4oKN0EnLaNRA/TJbJ4v0nfbiW56qW9Rb5wFaiW7noa1KG1FRAe9HYd894uruXyO9ASSIAURYI4wKtb/e+YsjY6/jKyBuxDPyPbvhZRj7lddsI1XLJCdV4R4jN8Tb8pSmDaVhpdniBM=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM4PR10MB6838.namprd10.prod.outlook.com (2603:10b6:8:106::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 00:26:31 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606%5]) with mapi id 15.20.5632.015; Fri, 16 Sep 2022
 00:26:31 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        "djwong@kernel.org" <djwong@kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: Is it possible to corrupt disk when writeback page with
 undetected UE?
Thread-Topic: Is it possible to corrupt disk when writeback page with
 undetected UE?
Thread-Index: AQHYyVOZuHnP7uLChkm+T/SiMC7uC63hFndwgAAc0YA=
Date:   Fri, 16 Sep 2022 00:26:31 +0000
Message-ID: <cec5cd9a-a1de-fbfa-65f9-07336755b6b4@oracle.com>
References: <44fe39d7-ac92-0abc-220b-5f5875faf3a9@oracle.com>
 <SJ1PR11MB6083C1EC4FB338F25315B723FC499@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083C1EC4FB338F25315B723FC499@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4429:EE_|DM4PR10MB6838:EE_
x-ms-office365-filtering-correlation-id: f1c7b27d-c08c-4901-6817-08da977a1ab3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 01ANpF9/loDJbUwOltxXuIQzOEZ2Y91djsuAnA55kivvByYZQ/gvYGebM3a8wLAm3aUqQ1ZohmWSTatVj50zYEEAFKjNRgUggb5KxYRWGAzozMLWumwZYvbjEsmq9uBYnQHhJafKqmuKQqiI3Qr4bfa1naRIKxTDReoM8J2Ho94ts3e8oJSIA01Z6YORzLSoOYoiI6ldxtkHAI1K9//+UFJ2QYHENlofa7+U0psaN58ANMfEJFe6+FscVhiT8LQ9IHcqnzDyT3ZHWzPMSmH7RIakB4gJdwbpxrNdovAOE4+O6wkwbA++J4mLflhnZm+V1KUR0VR9WJB0928kfh2qxIlmgpJQg3t4TdEQSKnCrHcXb+htaM5httBk9GQ74wBQgsK9RK/eZzxRItb3f36bna3iqufmcJHtjnO9IRD4KMOxFuVn6EnSsc+MdTlqUBE9xk7d6peT32JmUPdKrjIm+h9RxyWm81dGBnsXSaQPLBQ4YFGw39Z1F0//4GNN0y483rjkxCm8y0qJARphe0t44s49LY9FluYLqVWLgCJbwlcmOJLwdxaCW86+gK6vena1q1mLgxnJ0QKDyPue+AupPOwe1F2SrqMI/DmUcs1SkTm1f8IfVr8SkGEICQ8FPjmOJOQV1Cwqn3NmT/bSSY9BaxAJyD1XFvSkOnPsirw+43sUGKXEX7gTgsBXdg/O03sZyLVZ/fjkVjBm8+CkWPEK3RF006BSqtGzcxlSJZ4iQbhGzWE41f/jilzkLVqob6NvVL69+H4RsQ8pCXTaS3tk9KGrbF+/4knqJhT4DCYCOlrTFVkT8Zp8Cjh5HOeSHcb307fdNWxoJnxDztg0XfBr0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(2616005)(86362001)(31696002)(36756003)(31686004)(54906003)(71200400001)(110136005)(38070700005)(316002)(6486002)(122000001)(53546011)(38100700002)(478600001)(6506007)(8676002)(6512007)(26005)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(76116006)(8936002)(41300700001)(2906002)(5660300002)(186003)(83380400001)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmNUa0tncm1RRTY1TmlpdlRDWXA0KzhGZmlwZGh0Y0M0NkFBNVpNeXlGWmZh?=
 =?utf-8?B?UHpmRVdJbDZSZXViWXpRQXZuMi9KNWNtVUdjelJwUThsUXB6QWVzRXVrWTZ6?=
 =?utf-8?B?N00vVTBPNXNzU2xsNlNvRlhSOEQ3QXJQOHkyWGxLaGdLc0dQcXVGZWpaSTQ4?=
 =?utf-8?B?OG1DT0hBNmMzWFQvZWJrUmVzVUU4WERlNmh2U3BFaDdIL3RBYURkaEx5cFFE?=
 =?utf-8?B?cEpsalNmUk5TUlJpaXo1Ui9UYWZ2eC9KOEFEakFMZ3h1Y2dYOEpNRWV6ZGh1?=
 =?utf-8?B?Znkvc2hpSXV5T2x1Y3NRbkRjUERkSTZkTzBUZFFsUi92b05TRzV3M2pGRFha?=
 =?utf-8?B?dEhLTXZRRzZZY01FK2o3TXJwRE9vQlZtN29SYitqVDhqcUc0aU0zd0FZc2Zt?=
 =?utf-8?B?MXRPMHJMRjkwdk8zeHFBL1M0VDRkdmNNRHlxMGI1eWJBaG1wV3FYVmZrWklY?=
 =?utf-8?B?OTUrdmU1M1dkZkh5T2VETmpFSk1pdklVS0RLcTRPOWorbTFqVUR2b3NJeUI3?=
 =?utf-8?B?bkdqcU5vM1JpdkRqRnBWVUN4V3VZbFJNNWJ4YUF1VEdrK1ZjQ3QxRDRnQzVD?=
 =?utf-8?B?WmxEQ1JydUVKKzBaRE1rTUFqOEFrQkZPK3pERGZZSnVIbWc1OUFIaytIbW55?=
 =?utf-8?B?d2NCdnBhNGhaZlAyWXc0UkVYT0RaanBCRGU3dmRzZitySFprVXJwU3cyTlF2?=
 =?utf-8?B?ZjBpOTZ1Y09UbjF5ODZrdEwyYTg3Q2puMGJIU2JnTjlRbWZqeDA1MjZDM2NB?=
 =?utf-8?B?T2NoYzAvblNKTnlGUmxUOTJCYjNuTWUvT1kvaEJGVm1kclB6WXFMQ3NFZmRo?=
 =?utf-8?B?K20xUDBNNWFRaytCSFVpdTNra1JYZTEzd2tCaG9Rc1R5cGNiN1VwNm9sVXNQ?=
 =?utf-8?B?OGdLWm9sL2ZWYWJqenN6bzdldjlqblRCc0JOT1gwUDBUODJPQ05zYTNVRGRv?=
 =?utf-8?B?N1VRb0Zqc0NFbVpabFgrZTRWd3pJbVdCdDJNVmczeUlkSnRubkRZWGwyQjZB?=
 =?utf-8?B?Y2RTOEo1WkhNKzMyZDNSaWlMYnV0MEZoVG1VcGpSQXJGc0w3dzd6amljdzNm?=
 =?utf-8?B?V1MyTmZ3dytaUks5N2s0N0lWYzNyblcxNzlaMzhYQ0ZwKzZxNDlVb2Evd0pi?=
 =?utf-8?B?S3VQNXJ3UWVXYXlHQXp3S25SV2x5ZTNsTXExSTNQK1c0d1RBa1RoRXAyRXZ4?=
 =?utf-8?B?U2Z1Z054MFN2R0xkOXN4cC9scnRyRzF4dUp5TlhmNXR4bXo3SEtOakdvc3k3?=
 =?utf-8?B?dk02cm5EUVFWT0EyQjRsczdiRFdQUmVWb3FsMUZ3R2Mzbm5IYjRldDRiRXhM?=
 =?utf-8?B?QVNYNkFHSmZQdm43VHFQZG8ybUVuMnFKT2Q4QjJhbTJrZ2N2YkptYnF5c2hv?=
 =?utf-8?B?cndxVWJ4TGkyZHNMckRaUllKRlhKbDNWaWoyU01jT25QRGZ0N3kvZG1xaWVU?=
 =?utf-8?B?Y0E3VUVtMmVYQXc2OFBCREdjTWhhODM4M2FJWmFSNDM5V2xQbFdEeXAzb2d1?=
 =?utf-8?B?M3NISUt6T2ppczdvekx4bWVGSTA0SkJvemxIQnJLZEs5aGRrdStpUVFQZTFE?=
 =?utf-8?B?Wno5TTNmSm5zbTc5eHVaVm1DOWM0L0dyZmRITGNweU9KY2k2OGpMcUlkWFRQ?=
 =?utf-8?B?eUZXSjl2MTZ1WFhlcWQrOEJ1TDFPVE1NcW5DZ3ZjbE5SZVRDcWpaQTd0TE5M?=
 =?utf-8?B?QWU2V3hVOTJncE1PN0lDNVdCSGFJNHMxQWJ1Y3hBZnZ5SXJHdVBEU05GYjNY?=
 =?utf-8?B?eld0ZXBzNkJINUpsRFFnczN5VWF3M0xpS2Vya3FLZUdIQnpmQVZ5VTVDRUhx?=
 =?utf-8?B?RzdwRUF4OEx5NVA0cFptaHhPejdpODF4enZkN0NzV1dxVk9PZ3M4SHZXZWJP?=
 =?utf-8?B?SU50NFlSRXNTclp3SlZiNC9IbWl5b2xEWkdYbzVGcUVha2dkeE5PTzhZbUNZ?=
 =?utf-8?B?dmQ2YUM2Tnh2T2F1MEF1Y3pFVHVndTNwa1BRUnZTN0YyUVpZN1FSL0N6S2Yx?=
 =?utf-8?B?aGwvNjNyM3NiT0o0WUMzalV6ZzlxZWZIQzdMTzlOR2xoYkFjWm5rajNtUzVB?=
 =?utf-8?B?TTBlR29lWG5CYkh1dGZNRk8xNEw1WmZ1SHd1MVRnVGFTU2huZmpWK2ZEL1o4?=
 =?utf-8?Q?LXds=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F95A47BD7135B41A6602CA549626270@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c7b27d-c08c-4901-6817-08da977a1ab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 00:26:31.5647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YHuo207SG4gW9wf4VULAOA4Ds93juZX6eRs/kJv7O6QtdhEghXJFLe/8ems3i+oyKA5A/nr3hDETF7Wu8rbYyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6838
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209160001
X-Proofpoint-GUID: C2hc71ghcaF4ZQD9SiQJJ0WXs2k2_ISF
X-Proofpoint-ORIG-GUID: C2hc71ghcaF4ZQD9SiQJJ0WXs2k2_ISF
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gOS8xNS8yMDIyIDM6NTAgUE0sIEx1Y2ssIFRvbnkgd3JvdGU6DQo+PiBTdXBwb3NlIHRoZXJl
IGlzIGEgVUUgaW4gYSBEUkFNIHBhZ2UgdGhhdCBpcyBiYWNrZWQgYnkgYSBkaXNrIGZpbGUuDQo+
PiBUaGUgVUUgaGFzbid0IGJlZW4gcmVwb3J0ZWQgdG8gdGhlIGtlcm5lbCwgYnV0IGxvdyBsZXZl
bCBmaXJtd2FyZQ0KPj4gaW5pdGlhdGVkIHNjcnViYmluZyBoYXMgYWxyZWFkeSBsb2dnZWQgdGhl
IFVFLg0KPj4NCj4+IFRoZSBwYWdlIGlzIHRoZW4gZGlydGllZCBieSBhIHdyaXRlLCBhbHRob3Vn
aCB0aGUgd3JpdGUgY2xlYXJseSBmYWlsZWQsDQo+PiBpdCBkaWRuJ3QgdHJpZ2dlciBhbiBNQ0Uu
DQo+Pg0KPj4gQW5kIHdpdGhvdXQgYSBzdWJzZXF1ZW50IHJlYWQgZnJvbSB0aGUgcGFnZSwgYXQg
c29tZSBwb2ludCwgdGhlIHBhZ2UgaXMNCj4+IHdyaXR0ZW4gYmFjayB0byB0aGUgZGlzaywgbGVh
dmluZyBhIFBBR0VfU0laRSBvZiB6ZXJvcyBpbiB0aGUgdGFyZ2V0ZWQNCj4+IGRpc2sgYmxvY2tz
Lg0KPj4NCj4+IElzIHRoaXMgbW9kZSBvZiBkaXNrIGNvcnJ1cHRpb24gcG9zc2libGU/DQo+IA0K
PiBJIGRpZG4ndCBsb29rIGF0IHdoYXQgd2FzIHdyaXR0ZW4gdG8gZGlzaywgYnV0IEkgaGF2ZSBz
ZWVuIHRoaXMuIE15IHRlc3Qgc2VxdWVuY2UNCj4gd2FzIHRvIGNvbXBpbGUgYW5kIHRoZW4gaW1t
ZWRpYXRlbHkgcnVuIGFuIGVycm9yIGluamVjdGlvbiB0ZXN0IHByb2dyYW0gdGhhdA0KPiBpbmpl
Y3RlZCBhIG1lbW9yeSBVQyBlcnJvciB0byBhbiBpbnN0cnVjdGlvbi4NCj4gDQo+IEJlY2F1c2Ug
dGhlIHByb2dyYW0gd2FzIGZyZXNobHkgY29tcGlsZWQsIHRoZSBleGVjdXRhYmxlIGZpbGUgd2Fz
IGluIHRoZQ0KPiBwYWdlIGNhY2hlIHdpdGggYWxsIHBhZ2VzIG1hcmtlZCBhcyBtb2RpZmllZC4g
TGF0ZXIgYSBzeW5jIChvciBtZW1vcnkNCj4gcHJlc3N1cmUpIHdyb3RlIHRoZSBkaXJ0eSBwYWdl
IHdpdGggcG9pc29uIHRvIGZpbGVzeXN0ZW0uDQo+IA0KPiBJIGRpZCBzZWUgYW4gZXJyb3IgcmVw
b3J0ZWQgYnkgdGhlIGRpc2sgY29udHJvbGxlci4NCg0KVGhhbmtzIGEgbG90IGZvciB0aGlzIGlu
Zm9ybWF0aW9uIQ0KDQpXZXJlIHlvdSB1c2luZyBtYWR2aXNlIHRvIGluamVjdCBhbiBlcnJvciB0
byBhIG1tYXAnZWQgYWRkcmVzcz8NCm9yIGEgZGlmZmVyZW50IHRvb2w/ICBEbyB5b3Ugc3RpbGwg
aGF2ZSB0aGUgdGVzdCBkb2N1bWVudGVkDQpzb21ld2hlcmU/DQoNCkFuZCwgYXNpZGUgZnJvbSB2
ZXJpZnlpbmcgZXZlcnkgd3JpdGUgd2l0aCBhIHJlYWQgcHJpb3IgdG8gc3luYywNCmFueSBzdWdn
ZXN0aW9uIHRvIG1pbmltaXplIHRoZSB3aW5kb3cgb2Ygc3VjaCBjb3JydXB0aW9uPw0KDQp0aGFu
a3MhDQotamFuZQ0KDQo+IA0KPiAtVG9ueQ0KDQo=
