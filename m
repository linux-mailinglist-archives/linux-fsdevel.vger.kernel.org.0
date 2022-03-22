Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D054E49BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 00:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240618AbiCVXr2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 19:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbiCVXr1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:47:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68237532E5;
        Tue, 22 Mar 2022 16:45:58 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22MKxOsj017238;
        Tue, 22 Mar 2022 23:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cqSm+Y2F6Z7PiCQBgeoLfYE8XkYHha8gGj5oQAluJKM=;
 b=vdhFke/c23MnQLAumQf1uDpzV9uOTXYAg0oBkCktaIsuEe0RNhC8dZmvETarxAyU84L0
 G9XYPH+LM08lImxnr+74boFjS7TZK91A0eYwXZBYc7IG3cFfaWGCsEhV+bQ7oep0cSM9
 YaDp4xCTX0F3XfX29OxG93HL43RRypNiM5NSaEEsaVol2X2Icv5SQ1yff8OClfnwlLY9
 pFRKOs++Uule5WM09wXVxJ+6+Bv0xP2DpuqjHkCKvrSn04q+kDQlIcCMhR8b/MHJrAxv
 DBaY9alpNiQw2r/o8BHKZmodEJbFvIRrPYka0VeE59+zvM4OLiWf2xqOY42l7uiuYocW QA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5kcqu8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 23:45:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22MNaOZB087024;
        Tue, 22 Mar 2022 23:45:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by aserp3020.oracle.com with ESMTP id 3ew701dcs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 23:45:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdwmX9emygoSHm+H7gNUjV1jg/NIf2mqsAQoI1l9HOTOm/fKIfzVxgBisV1QO5ABs5XGeiypVYsBQzb8HUCOP6fWwbsdT/cSC4NVVK/j5b6tP1EmUI5wnLFuGOgoBQvLUvts2G7KZtDaIIQuLt2izavhlYtJcyC08eF+TcsghbB2Xb4/kKYut9UClA5l84m+nhdO5zRPFGT3fGPEPY4JiqmzFvkAIdYuOFqfAfBFT8HF7wEGLDT13EFM8gyun7TVNm2PbsUCfjrMqBSzrAdVb+Oja3GbTsvkGuEbsoSydHAupucJF9PyFAVcdIHycXP4IdUCzrXzlXr6UwMIDzJHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqSm+Y2F6Z7PiCQBgeoLfYE8XkYHha8gGj5oQAluJKM=;
 b=ll/j+HOHayzyO5JZ3FTaLKtH7lUChiTqrVLQ1kMPvbIQB3/NXcO8SyC/t6tAr5yFuI6l8NIKpH7EG51CwxIqpDU3JzRgoJR/l5FgAXEL1aFNvXFIrAnaCUlK3FD2iAIXjZW/SqiOS0M4+AzSHQHCOazXP/vU4YB9U05qRI7zUgEGb5b9GcaiT0NCCXoB0nhkapNFdTYAU2LAgNYBfUw7W1s12o+LGNbJy0IzhR6uXYDe0Ga3pvgd4gm+2wBPoTY1Qi5Okss8oyQSQeocMAKSdTLTi68ezP7+wyT18bdF4lAWcs7r6YNII9H2SQC9zdC3PVBZzmpavVuFFaZGWKD6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqSm+Y2F6Z7PiCQBgeoLfYE8XkYHha8gGj5oQAluJKM=;
 b=jJZWFStnk5gSQ7KfImLHgeyfkXPNd0Slu2N+spRWt5jmVOe4izQnC7czJwKH+S38K51dECRfgZ+fAN0prohSWjPcT6LxV4NksEx+SZujn4bpGUuRZYBIEKXIO9RVcUTd2iGp7hIR6PwwVt7EjAegFTRbIZuDhESpWjMAdnkLY/k=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BN6PR10MB1876.namprd10.prod.outlook.com (2603:10b6:404:ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 22 Mar
 2022 23:45:38 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336%7]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 23:45:38 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v6 5/6] pmem: refactor pmem_clear_poison()
Thread-Topic: [PATCH v6 5/6] pmem: refactor pmem_clear_poison()
Thread-Index: AQHYO1qtZS40sRPvMkmJ+l2u68rXNKzLHcWAgAD5YYA=
Date:   Tue, 22 Mar 2022 23:45:38 +0000
Message-ID: <20fba522-c978-8d6b-5498-8e768897a129@oracle.com>
References: <20220319062833.3136528-1-jane.chu@oracle.com>
 <20220319062833.3136528-6-jane.chu@oracle.com>
 <YjmOb0dSY9GG/Q6r@infradead.org>
In-Reply-To: <YjmOb0dSY9GG/Q6r@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5232691f-e6c6-494d-abe9-08da0c5e1152
x-ms-traffictypediagnostic: BN6PR10MB1876:EE_
x-microsoft-antispam-prvs: <BN6PR10MB18760863D747759880893611F3179@BN6PR10MB1876.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CQTRBg1ppE7EbOTZV37PHHSUunoAwODf7ZMoNQq60wNNboTlP2MEdQjRUN7craFjGFhoi/HjYAJ6l99kf4hkdHrTBiY0zO3BvGn3OQWkXWsE6Ylroq0mOSjzJL8THfAexp9ciCR1vvqJCTl/VA9Th0yOJ9XnXeojhn3xqZkoWs3cRVvOrlAk+r97fOTg6ethPaNqMKOychD8Hyw5gg8l0vH07Tm1ywjUoNCaS62D3XeCkw6wQAQPx8Y2LqBShXukSCRRcpgq8Tl6YMGZnrO5Ch7lWoRyEOvFBGzS5K1JTwfDwp/IW1RdsdKBkhBP+yuKsAhdCeJIgd918aVn6wnh24lHOtWTPLjpkoJo2F/22YPkPX1q8/fpzGr+vKqdUuPxW1cM3Ba83DItXoLyUeSDPyyHQks2WZgQatTCYASJm5/FdxycHqj7i6xXatj5k+cZfFIxHKT5f+rpA24yP85992zjmEhxlR76MyILyr/LdCQndVTGAT1dm5aWYz5w7dEUUgG7wl+uBwow9c7PpT73NKIqeofclExTQfXVIZ1X4GkP3whOrVxE9koV4xAb73eL/qH04+CXZnXQFv7Lw/aCQrsf4xvG5D1yBsFKdXBdkaaaXgnel3qpBVa3bN0dkE1rHPo96p8yvgRH9It7yDv6bAVuVaEKgDZe6rrsg1nDiP2ekaq9YQAktrjXjGd5ZwIEkFg4injjIf9gF3159so8NPlSuskaqtFwXVl6QV9M+9jb2irgei1Pw45zdaHJ/Ih/jaGT2yNL2AesC3898bAi8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(5660300002)(8936002)(6916009)(54906003)(2616005)(316002)(186003)(91956017)(38100700002)(8676002)(64756008)(66946007)(66476007)(66446008)(66556008)(76116006)(122000001)(53546011)(4326008)(6506007)(83380400001)(6512007)(71200400001)(6486002)(36756003)(508600001)(38070700005)(86362001)(31686004)(31696002)(2906002)(44832011)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3QyNXJQRmtIMWlsbjVLUFFLUFI1WVpOd1JTcEdHaklsQjAyS1B5UFJJcHp3?=
 =?utf-8?B?UVhaanRIRGRwajVIWXBlQ0xhencrRFNVNVhFTjBHK0I2VDJPVFFWUk15dEow?=
 =?utf-8?B?UlEwNCs2b3FydiszZ29qbEp2YjNZNnh5MnIrZ0FQRUs1Y3E2cnNtWVF2Tm5O?=
 =?utf-8?B?OTF6U3F3MlplV0NSWGR5YklDSVpCTk5JMy9BZ296bVNjK3RHN0NtSENIcVNK?=
 =?utf-8?B?VUlWUWJadk5Dc1Z2NXhrNUdoQURMRWRpMm1HbnVKYmNhRDUzQ1JLeTJJUjl0?=
 =?utf-8?B?MGpBWVFXczBJVDV4d3lqUUUyWmo3M0p1Z2FIMktYRGNvcUtsWURCcTB5QTdO?=
 =?utf-8?B?eDlMOERzOFJwZWtDRXg4Qzc5Z0JQK1JTSExCSFJPOHNpMkUrU3AwdnlWbjRH?=
 =?utf-8?B?TTA5VzdpN0pTakU4OUhST3I5S0hPU3hKamIvYWFzWnJIU2N3MFZCVmZyeUNH?=
 =?utf-8?B?b1hmd29WbkptSTBZVllrQ0hnd1k5STkwNUgxblJub1JCbU4xYzEzZ3ZQd2Na?=
 =?utf-8?B?bldDVW5PUk85RTlET0dpNW9mTXRPZk9nU3kxWHFOc21sajZXZmpmQjVmWUp4?=
 =?utf-8?B?Yzc0VDI5QmowcE1WNWNSZ1o0YldBekR1TnpWbk0xY3h4Zk5BdVhRUzVoMjY2?=
 =?utf-8?B?clN6UUIyVjZEejdadGhvcElzN1lNZlFGQk5yRlBnVTVEUFFRZHFIdFZCMi9K?=
 =?utf-8?B?RDkvUUZhZnFKcmJVVGRBdnlETFI5TWNqdFpVZjd3RW8xTEE1WG8rLzJ1Nk9G?=
 =?utf-8?B?OWExSWRqMmd6ZTg1T09pejZDRzNLMGZ4R0FkdFJiTFpOTkVxd1JyUWxqeVpF?=
 =?utf-8?B?enBvQ1hIK2NCZllOSDI2VHVUL2MwYVBodE85VUdBaGZZZHhXN2swQVJ1TE8y?=
 =?utf-8?B?RVhLUnVkT0lQRllGT0xsL3RHOTFuaHpFeGRjK09qdHN1a1B1dTVod2JQYTZB?=
 =?utf-8?B?c3Z1MjNuMHYxTmVUZGlmWWxzb0lhTG0zQjIyakVXZUEyUHBOVms1Ym9XbG1w?=
 =?utf-8?B?MkozQ3cxTCs1SGtEUnJWTUdsaHJaV1A0VENRMi9DQjJDZE1ZV2d0dXNrTkVa?=
 =?utf-8?B?dEpYSkFOa1lFNXJ1YmhvaDZiZEhySXJoRzU4SVNLaFVlS1JJRFdrbmF4ZFhX?=
 =?utf-8?B?QmVHNmJFcWMxTGI0dVRCRXJGNDl4ZVRPR0k5NzdiYUVMNFFzcGZxOU10dnRU?=
 =?utf-8?B?b3hvVXNQU0l2ZWI0Rnl6cFc0TDV6MURoSnBQb0pDdE5sZGlncVlOOTA2WGcy?=
 =?utf-8?B?ZTlhODltQUpUS3RKSmNXK09udHluQzQ1Wi9IcFU2NjVPM0xiV3ZLN0RkaGxU?=
 =?utf-8?B?ZjRJSHYwaDhsaXRldysrMHZGc0NjUVdqbDU2VjZzRzNvMEZFbkh1aHVCeXRm?=
 =?utf-8?B?Zm5RQi9Ta2twZjdvMnpudVZXd0dJVm9wRm1RSjZzN01HUHRndGcreU9DZThF?=
 =?utf-8?B?ci9DUlRGQnVMYno3YndPeTF1S09hSHFiOHVRVHFCTkJHTzNDMFFTem9UNHgv?=
 =?utf-8?B?WjdEUWZ6Qk5NVGpGR3BwM0RVbW5wSUl4Uy8rSmowck52MUlpY1JCSEM2OCtL?=
 =?utf-8?B?eUwwVlhvQ2ZKRS9uMXBLY0k2RjBJbTUyN3ZTeHBRYWlSV3NsenBzU1RqRmF0?=
 =?utf-8?B?enZibG52NUVuODFTcEoxWlZTS3JXczd6Rm43WnlpOHgwS2RoZzlJTTAyeDhD?=
 =?utf-8?B?eVVQb2theWsvT29tREVSOXVBMXZ1OHhMMitBYmhsYzVlOWo4Ym9pZTJBSFZh?=
 =?utf-8?B?eGRwb3BvdTRUelRYVnhvWVpnYXB3bWhVd0RsVS9nMGk1YmFqNHVXTlhrTHVi?=
 =?utf-8?B?MER5UElxM1J2RWNZYmJwN0lkRDdqYXpEWHdzVy9nSXF6cWE2SnVzcVZwMWFx?=
 =?utf-8?B?bFVTQVBEODRTVUtINGlqbmgzaEk2WHB0QjRiRTk5bE5RemFYMkRRWi9RSHVo?=
 =?utf-8?Q?hB7AGn1GoSWxiC7+3/uhSqBoMPFe7Yyu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <873A5AE97FD1CA45A1362A287DBE5C30@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5232691f-e6c6-494d-abe9-08da0c5e1152
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 23:45:38.3123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qiNjwg9cUpAIoL5eBWDHxeu4J6G0j64oteUBkXuysaCChfRgbaF5RiftX4w4hnwIdr+N1c7uS0EZ/CTcCjvg0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1876
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10294 signatures=694350
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203220118
X-Proofpoint-GUID: VXWfLBM5RgYvil34TaZkgkJ6ebVTSQwu
X-Proofpoint-ORIG-GUID: VXWfLBM5RgYvil34TaZkgkJ6ebVTSQwu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMy8yMi8yMDIyIDE6NTMgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4gLXN0YXRp
YyB2b2lkIGh3cG9pc29uX2NsZWFyKHN0cnVjdCBwbWVtX2RldmljZSAqcG1lbSwNCj4+IC0JCXBo
eXNfYWRkcl90IHBoeXMsIHVuc2lnbmVkIGludCBsZW4pDQo+PiArc3RhdGljIHBoeXNfYWRkcl90
IHRvX3BoeXMoc3RydWN0IHBtZW1fZGV2aWNlICpwbWVtLCBwaHlzX2FkZHJfdCBvZmZzZXQpDQo+
PiAgIHsNCj4+ICsJcmV0dXJuIHBtZW0tPnBoeXNfYWRkciArIG9mZnNldDsNCj4+ICt9DQo+PiAr
DQo+PiArc3RhdGljIHNlY3Rvcl90IHRvX3NlY3Qoc3RydWN0IHBtZW1fZGV2aWNlICpwbWVtLCBw
aHlzX2FkZHJfdCBvZmZzZXQpDQo+PiArew0KPj4gKwlyZXR1cm4gKG9mZnNldCAtIHBtZW0tPmRh
dGFfb2Zmc2V0KSAvIDUxMjsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHBoeXNfYWRkcl90IHRv
X29mZnNldChzdHJ1Y3QgcG1lbV9kZXZpY2UgKnBtZW0sIHNlY3Rvcl90IHNlY3RvcikNCj4+ICt7
DQo+PiArCXJldHVybiBzZWN0b3IgKiA1MTIgKyBwbWVtLT5kYXRhX29mZnNldDsNCj4+ICt9DQo+
IA0KPiBUaGUgbXVsdGlwbGljYXRlIC8gZGl2aXNvbiB1c2luZyA1MTIgY291bGQgdXNlIHNoaWZ0
cyB1c2luZw0KPiBTRUNUT1JfU0hJRlQuDQoNCk5pY2UsIHdpbGwgZG8uDQoNCj4gDQo+PiArDQo+
PiArc3RhdGljIHZvaWQgY2xlYXJfaHdwb2lzb24oc3RydWN0IHBtZW1fZGV2aWNlICpwbWVtLCBw
aHlzX2FkZHJfdCBvZmZzZXQsDQo+PiArCQl1bnNpZ25lZCBpbnQgbGVuKQ0KPiANCj4+ICtzdGF0
aWMgdm9pZCBjbGVhcl9iYihzdHJ1Y3QgcG1lbV9kZXZpY2UgKnBtZW0sIHNlY3Rvcl90IHNlY3Rv
ciwgbG9uZyBibGtzKQ0KPiANCj4gQWxsIHRoZXNlIGZ1bmN0aW9ucyBsYWNrIGEgcG1lbV8gcHJl
Zml4Lg0KDQpEaWQgeW91IG1lYW4gYWxsIG9mIHRoZSBoZWxwZXJzIG9yIGp1c3QgImNsZWFyX2h3
cG9pc29uIiBhbmQgImNsZWFyX2JiIj8gDQogICBUaGUgcmVhc29uIEkgYXNrIGlzIHRoYXQgdGhl
cmUgYXJlIGV4aXN0aW5nIHN0YXRpYyBoZWxwZXJzIHdpdGhvdXQgDQpwbWVtXyBwcmVmaXgsIGp1
c3Qgc2hvcnQgZnVuY3Rpb24gbmFtZXMuDQoNCj4gDQo+PiArc3RhdGljIGJsa19zdGF0dXNfdCBf
X3BtZW1fY2xlYXJfcG9pc29uKHN0cnVjdCBwbWVtX2RldmljZSAqcG1lbSwNCj4+ICsJCXBoeXNf
YWRkcl90IG9mZnNldCwgdW5zaWduZWQgaW50IGxlbiwNCj4+ICsJCXVuc2lnbmVkIGludCAqYmxr
cykNCj4+ICt7DQo+PiArCXBoeXNfYWRkcl90IHBoeXMgPSB0b19waHlzKHBtZW0sIG9mZnNldCk7
DQo+PiAgIAlsb25nIGNsZWFyZWQ7DQo+PiArCWJsa19zdGF0dXNfdCByYzsNCj4+ICAgDQo+PiAr
CWNsZWFyZWQgPSBudmRpbW1fY2xlYXJfcG9pc29uKHRvX2RldihwbWVtKSwgcGh5cywgbGVuKTsN
Cj4+ICsJKmJsa3MgPSBjbGVhcmVkIC8gNTEyOw0KPj4gKwlyYyA9IChjbGVhcmVkIDwgbGVuKSA/
IEJMS19TVFNfSU9FUlIgOiBCTEtfU1RTX09LOw0KPj4gKwlpZiAoY2xlYXJlZCA8PSAwIHx8ICpi
bGtzID09IDApDQo+PiArCQlyZXR1cm4gcmM7DQo+IA0KPiBUaGlzIGxvb2sgb2RkLiAgSSB0aGlu
ayBqdXN0IHJldHVyaW5nIHRoZSBjbGVhcmVkIGJ5dGUgdmFsdWUgd291bGQNCj4gbWFrZSBtdWNo
IG1vcmUgc2Vuc2U6DQo+IA0KPiBzdGF0aWMgbG9uZyBfX3BtZW1fY2xlYXJfcG9pc29uKHN0cnVj
dCBwbWVtX2RldmljZSAqcG1lbSwNCj4gCQlwaHlzX2FkZHJfdCBvZmZzZXQsIHVuc2lnbmVkIGlu
dCBsZW4pDQo+IHsNCj4gCWxvbmcgY2xlYXJlZCA9IG52ZGltbV9jbGVhcl9wb2lzb24odG9fZGV2
KHBtZW0pLCBwaHlzLCBsZW4pOw0KPiANCj4gCWlmIChjbGVhcmVkID4gMCkgew0KPiAJCWNsZWFy
X2h3cG9pc29uKHBtZW0sIG9mZnNldCwgY2xlYXJlZCk7DQo+IAkJYXJjaF9pbnZhbGlkYXRlX3Bt
ZW0ocG1lbS0+dmlydF9hZGRyICsgb2Zmc2V0LCBsZW4pOw0KPiAJfQ0KPiANCj4gCXJldHVybiBj
bGVhcmVkOw0KPiB9DQoNClllcywgdGhpcyBpcyBjbGVhbmVyLCB3aWxsIGRvLg0KDQpUaGFua3Mh
DQotamFuZQ0KDQoNCg==
