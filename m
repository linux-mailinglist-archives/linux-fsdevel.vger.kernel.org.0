Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B538064ADD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 03:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbiLMCjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 21:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbiLMCiF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:38:05 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B531E738;
        Mon, 12 Dec 2022 18:37:20 -0800 (PST)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCMKDks027794;
        Tue, 13 Dec 2022 02:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=dX7eKy0dTsE07ZhSSuBXld0RR7lJHMxB0ctZurNCFAU=;
 b=FbxsyL41N2R28HmqPGL20hoLYWAFJgqZ0z+jmtFAKSh53JTGOrmrZhlmpOs2IqCwEbq8
 EBt/A3XvnynLuBiKmwaQN2T3qNvs1000nfR6Vc+bKtnXnWDhyypK//JKAgZXlOaNIzdn
 imAst3i42qNEXplqJBS8ebE375riUMOz/zQ3I6NdrnLZbEgTtnsVppkRM4sGO2QoAriu
 RlIB+WezlZZbKo+I/hpqZmtdkl9tvERZ8DHfH/SFkhvdolJA30QWvrHh6b9VtVX8S3oH
 WEwq9tE9YyLTWT52hlLPevZFYTNfzTcfosZqNVwsclVRkSNX6RGzVpVgjM9hMMdoQLX5 7A== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2041.outbound.protection.outlook.com [104.47.110.41])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3mcfh5jkrm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 02:37:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1wYk19odN+rFXemGy4gfT9L0pxIpCdYDdcF9lXuVCel4SjhEmwiEnsizeYL3ResUX6pFFe1xb0AQMDOdnAujosmIWd5woXuq5Gf61Q4XGeraIYHoiqAKAWiH2WkgzOrTYfXkodVH1UPfAqrOMmLUN96gKoJ8WcdA5oRs+Jnf5yinyhh/P+/EkXf99NF2dxZZJAp7Bmzy+g4yUgJntHMli0RHHcwWANHvAsCCcuka31T8lFIOktKiC6vpwNyByQm/FsHmR5nShFyHy5YrXbxhHZU1QGb2a+PHVvLFFdPMb54NbV7qUYMnS60HoHH6MZ5dOnIOU9uzERSulCEPmGRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dX7eKy0dTsE07ZhSSuBXld0RR7lJHMxB0ctZurNCFAU=;
 b=ZkBfW1X+UwKJmag+wQb6Vi1Q4RQGtzyrYQChXb4bAA08Jpk19ZwgUenbs1sHZ7HxctTL6U9OgB/AHofA0qI5Np9pib5Vjrd4YrRUkgDhW4SYwMpMy7pKFFFEZ3Z3FP0VkiC1L0uUztckmrWubYsTjrK6ckGSTRstyn+ICLEkEw4A/QMDhcelr84+0bboKKe3GSYYJZnXGTl/6NYfWMqbN8QMrRadVzCaVihpGBormN+o6fFwWB0Q9hpIdaTslkbInWVLJkOmJ+qjEDqg9L0oS0LgF86Z5b5fTsDDLRd5KCLPd7dsAyJ2HkLNU2UoHVUkFWXZy9WboIbb9FZ4xw2z3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB6948.apcprd04.prod.outlook.com (2603:1096:101:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.10; Tue, 13 Dec
 2022 02:37:08 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de%7]) with mapi id 15.20.5924.009; Tue, 13 Dec 2022
 02:37:08 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 6/7] exfat: fix overflow in sector and cluster conversion
Thread-Topic: [PATCH v2 6/7] exfat: fix overflow in sector and cluster
 conversion
Thread-Index: AdkOmq99zRXgAzKURlGtnFNFRSw9uw==
Date:   Tue, 13 Dec 2022 02:37:08 +0000
Message-ID: <PUZPR04MB63164078AA37CA1A2BCF159881E39@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB6948:EE_
x-ms-office365-filtering-correlation-id: 19179749-d7d1-4ee6-67fa-08dadcb2ee6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xV0+uieF5v8PRmrYxBy0BQBlONZZQZSoaHnwCCLNt4akPTV/5snZDntH5tWg79CAJt67w6PycHVbXXlxEvy+bpf3idh87HKa0orS2YUAlINyjLSYK1Dl+PewEqpegpTpObcOsrhpYH9w7JypbFOhVNeB7j2BC+9Q0dCeCu3vl0j6cIXAyfrt+JwiRNCmP4q1fqjERtkQbfgwaXE9dn3uxpbHrKAl5T40ZydG8LiveyZoLesIWt6VIrhpu6Ke+HcDf6+qJlcCHrWAiUxahl18S1oXZqJi6z0EGUFqOpLZBHELa7HSS3bPqLu8UMjs6iu2el/WK/64n8KlaD4Bmlxz0OK6mi3Uzhe4EL8dmVy6ATjXow2aC51043AxS81JSgVpDWuBODE9liJyM0/yUGsqy88wbxUR155lTd2ETQEvdNUmugmps43k7XkQg+E10qUBvGyLycRhG9RwBTNrEbnGQVkGcRKx/aclFnH/CItYLjsYlcY2KgP5yDbGy2gnYrBMHbHf/yQrXGXdps/W11Yfrj3X/YgWCDnZSbI4TZi4gYheewo3LYFnzxkbhLFAdYwBvSgZ6J47cf1K7xTnXViMhPIF+LW+mXgeOtFhebTAHI6KiArlWCFaGJFVaB5uRsyTSsD/BhuXPPy4T1ct9r5I8p7lajYHmh80i3Jn6mFFOLE6Zx+n004FfRwAYIM28CdaaIM6gi8rWEZvpU4OnrQzXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199015)(86362001)(82960400001)(38070700005)(2906002)(8936002)(4326008)(8676002)(66946007)(66476007)(66446008)(64756008)(66556008)(4744005)(5660300002)(122000001)(38100700002)(33656002)(83380400001)(478600001)(110136005)(316002)(54906003)(71200400001)(76116006)(55016003)(52536014)(41300700001)(6506007)(7696005)(26005)(186003)(9686003)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1VUY3BQTzdUbW1haTFSMjVLVXlpN25vRFY1WURqK05iWGF3by9vSWNpWFg4?=
 =?utf-8?B?Z3lvb25BcmJCOUlNZGxYTnFaQW9raFA5UmN6OTZnS2ZveURkNGtPa0sxUExq?=
 =?utf-8?B?aGZEc1dwNU1EdHVPTWxZVDl3RnkzdCtZQ2ZhZDBnbFo1bnNZOXlKdzBsb2tM?=
 =?utf-8?B?WU5rRDdkV2NubkFHTTFUU0ZZQktXY0szTWRhK0VLWnNSaHlXZVF6VnlidzA5?=
 =?utf-8?B?UG5OSDA2Vm1OaVB3Mzk2WnN4U1hrNExwK2s5MXhvNjBseXhBY25HMVYxRkV6?=
 =?utf-8?B?SzZEQXo0MFpGMWNrVVRFZHlzdVJkSE9uaS90d0JOMENsa1NWeUFNVjk5M1lB?=
 =?utf-8?B?Y09UNEwyYStxVmdmbnpRbXZxcFU4SHFtbXZGSVk0S1pTSEY1b3hkaThLY1Fx?=
 =?utf-8?B?MytEVC92dURKMWR4RkR0WjBzUVRtV21vc0VZc1RMOXo3dnBlQjZJK2xHbW5J?=
 =?utf-8?B?NE5ITXNVMmdrZ3FWSkpvLy8ralg3VEx2RmhGdzZGeW42Z3NsdStWSDZrV25M?=
 =?utf-8?B?YTI5eDZ6b2luUzJybDdsbCs5SkVieGZSUDFLaDhtZHhvZDVqNlBRYTBnTjBV?=
 =?utf-8?B?WGoySWlJRCtER3JBLzRxNms2UE8wY05uMFdYYmVDMmZJZEZkQnlCRjZUMUJP?=
 =?utf-8?B?SStDSklaRkYzU1pFelNHVTVBbktKUW9sOWx4alFrcWxSWFVpS2Qvd21BalRP?=
 =?utf-8?B?Q1RqSlp0clI1WFV3eHhvY21aWk9PcnMwa1p3TG1UNGp5L1ZUOVErRHNQbzYr?=
 =?utf-8?B?K2xoYnpPckFNSmZ6YTk0cmM1Z203aGtoRzdVYml6ZktySkx2b3FJR3BtSzJR?=
 =?utf-8?B?OTVHd3NkMjFGWndENHJKQXBDelV0WGsrUGRYL2pvUGpyVTRwZlVpQmwxaThD?=
 =?utf-8?B?VWJRZGhMb29tM3hPcjBiQnM0eFRVbkZYZ1h1L0cxYldPeGlJSWVSNk5DeTBa?=
 =?utf-8?B?ekNRa29JSVpEK09WS2ZHYUNEaHhpZVFGSW5McWNSby9kbml4ZkVRY2JhcXo5?=
 =?utf-8?B?bGluMHVTT2pRa0tIM2JLSGlRaEJPMWFRZm5WKzhlcmhHeEZ4KzdPcDM2bTJn?=
 =?utf-8?B?d1FDanFIQld2aHdzUC9HbXNvVGlWOUhLQTRMMmtJRDBlLzZhalZBU1pTS01Z?=
 =?utf-8?B?cGJlNURwZ0doSy95bGsxZGM3dHpmcDlneGRTRjlMMzg2R3pFa29OZXV1Y1gw?=
 =?utf-8?B?ZC90ak16SWYyMnI1QnlkdTdRNnYvK1JFUitpT2xrNmhhZjNST2pUN0RFL2Vp?=
 =?utf-8?B?YlE4S3Q0RldFOVFxVlpmTnNtL2lWNXNzdklBbFJuN1R3VnpLSEJKZ0JiQ0J5?=
 =?utf-8?B?cWRTQXRxWUVkcWZUQis3N1dFY2Zmd0U2alpVd0ZyZFZwMDZtNEY3a3RoY2s2?=
 =?utf-8?B?WDdrOUdKako1ODIzak8ySnAyK2pCRmVXS2duRVNPZ08yc0ZoNS9XS2FlNmYx?=
 =?utf-8?B?RFZOalhLRVA3ekxsTGVoZGFDdVBsN3NWQWJuR0RsSmF2OXA1aXVveUMrT2NH?=
 =?utf-8?B?amVNL29TMnUrVy9yckRzRzkyOVdnWlpRSFBVaksxamtFVk9ZWk5KN3RDeWpm?=
 =?utf-8?B?bjBjaGFiOXVRTU9ydjdDTFlaanZURU4xQUIzMGlVajZXd2o4SG44TDdidE1Q?=
 =?utf-8?B?WXIzMmFFdnFoa2NESDQxWjU3ZVNrRjF4NEI0UXNyemJxK1J0VHhiNm5Kak9U?=
 =?utf-8?B?akQ0S0RuN2JRbFRsb3FHZ0p2cC9abGpmYzBGSDNGakpJdzVUS1pWSTZkbFBq?=
 =?utf-8?B?VmxxeDVEaFY3QlpNd0JCVjRKRVNDK2lDZWFYUHl1eTdZYS80ZlV3MTlRVUJP?=
 =?utf-8?B?L2JiZjdTcmVnRTJraUIvdlQ2Q3BMckVqVHlKU29sSjZiTVpTN3V0YnIxT2Ru?=
 =?utf-8?B?UWdqY0k5V1lsWDJmQzJjYm5USjBIdm1STEx1Y25hbXVsRGx2VStmNG9rRFhq?=
 =?utf-8?B?MXkxQ1IyNjJKZTVYVW4xUmZ0SnorWFh2SUtiZ0JKd3QxMGFjMm00MlNBcUlR?=
 =?utf-8?B?R0lUNkIwbXYwMDFZdFg5UThXMFl3YXNRbEhJRW1qY3hLKzcvMEVmN3VwTzYv?=
 =?utf-8?B?SGM4Qmdidkg3WFVNeHpKY0hxUHFTTGhCUFZEREJxclcyTjEyVTJCaXBKQXpz?=
 =?utf-8?Q?bBUfT9Qy007597EhNFA5PPTPh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19179749-d7d1-4ee6-67fa-08dadcb2ee6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 02:37:08.8314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x8u5wvgYu+shyrJUsAajRF9hkbeGh6Dd3W1X59OQYRHrb73zvzwGRXQeVnJU6r6B3Xexs32PvO7eesRwi3hxhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6948
X-Proofpoint-GUID: XtaIQHyZnd5pB90RAIzf9e0mPBAdMhpd
X-Proofpoint-ORIG-GUID: XtaIQHyZnd5pB90RAIzf9e0mPBAdMhpd
X-Sony-Outbound-GUID: XtaIQHyZnd5pB90RAIzf9e0mPBAdMhpd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

QWNjb3JkaW5nIHRvIHRoZSBleEZBVCBzcGVjaWZpY2F0aW9uLCB0aGVyZSBhcmUgYXQgbW9zdCAy
XjMyLTExDQpjbHVzdGVycyBpbiBhIHZvbHVtZS4gc28gdXNpbmcgJ2ludCcgaXMgbm90IGVub3Vn
aCBmb3IgY2x1c3Rlcg0KaW5kZXgsIHRoZSByZXR1cm4gdmFsdWUgdHlwZSBvZiBleGZhdF9zZWN0
b3JfdG9fY2x1c3RlcigpIHNob3VsZA0KYmUgJ3Vuc2lnbmVkIGludCcuDQoNClNpZ25lZC1vZmYt
Ynk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L2V4
ZmF0X2ZzLmggfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9leGZhdF9mcy5oIGIvZnMvZXhmYXQvZXhm
YXRfZnMuaA0KaW5kZXggYTFlN2ZlYjIyMDc5Li5iYzZkMjFkN2M1YWQgMTAwNjQ0DQotLS0gYS9m
cy9leGZhdC9leGZhdF9mcy5oDQorKysgYi9mcy9leGZhdC9leGZhdF9mcy5oDQpAQCAtNDAwLDcg
KzQwMCw3IEBAIHN0YXRpYyBpbmxpbmUgc2VjdG9yX3QgZXhmYXRfY2x1c3Rlcl90b19zZWN0b3Io
c3RydWN0IGV4ZmF0X3NiX2luZm8gKnNiaSwNCiAJCXNiaS0+ZGF0YV9zdGFydF9zZWN0b3I7DQog
fQ0KIA0KLXN0YXRpYyBpbmxpbmUgaW50IGV4ZmF0X3NlY3Rvcl90b19jbHVzdGVyKHN0cnVjdCBl
eGZhdF9zYl9pbmZvICpzYmksDQorc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgZXhmYXRfc2Vj
dG9yX3RvX2NsdXN0ZXIoc3RydWN0IGV4ZmF0X3NiX2luZm8gKnNiaSwNCiAJCXNlY3Rvcl90IHNl
YykNCiB7DQogCXJldHVybiAoKHNlYyAtIHNiaS0+ZGF0YV9zdGFydF9zZWN0b3IpID4+IHNiaS0+
c2VjdF9wZXJfY2x1c19iaXRzKSArDQotLSANCjIuMjUuMQ0K
