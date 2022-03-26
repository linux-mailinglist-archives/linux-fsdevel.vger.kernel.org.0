Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE81C4E7F92
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 07:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiCZGdv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Mar 2022 02:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiCZGdt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Mar 2022 02:33:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1642289324;
        Fri, 25 Mar 2022 23:32:10 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22Q1uSdS004721;
        Sat, 26 Mar 2022 06:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cIv1hf7Mm6pmH06BrTJ6HMerEgjP2XVCaNkelZOjDsQ=;
 b=G7CtZys+p/WQksu+PcsotNpitfV2ZAPZbZU3Zv091adNPAEKQULRaEqHilfkDgTcfN4u
 hbbfzUOvHd1zXqMMW5guyjywS3dMcM+aLGMUsJTr4ubzxJmuSeJFYGkGq0/ilrJ2ekji
 k+j8QRL53iJlpUhIKaHPHci6P3RS77YWRd/Zadb3h0oLTQkjMHDBmYF7Z+AByM0DVowU
 lN8XNC1ST/YXn2Z3F09LSrzNLIrn1ab5RZe4q/OAp9vIBC/wbMW85Vmz/5HWquuVJRPB
 pnH8b4KRE7BU3Jn+fTsrbyvfyYMYgIb1khi//x4KNmJfrUcKModSAWm3m+66cBrfCkzU ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm2864j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Mar 2022 06:31:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22Q6Hfsd165703;
        Sat, 26 Mar 2022 06:31:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3020.oracle.com with ESMTP id 3f1tmy87j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Mar 2022 06:31:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPofADi9rPQgEBqEtMiLTEyeEdsi6J93DWg+4rkULqkIP6HjtckALzsX4QOjGWMce1u81wEEAp6S5ArqnnscVaVT5onvPGIhsQC2THw7D2lsFh2sOnJCvgfcszsqju6ONyZED6qZ4KRfcvcuqp0luv/hHZWNtMpIkxqUfmg0uSa8yffvTzwxYUDdEWIK3LSdWNBEZjt86vywZLtciHueeSffOMLmhu1dZV4H+vx6NF6M0cGcmPrh1DWi8G4j8E2PUvgC9vGPb5YUiJSJKQ1v8UuM99Xf8/g9eGXizLHKaiehltdmPD5QuvFLPuQ1poMYCT+fBR9U44kAXLrBJYtAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIv1hf7Mm6pmH06BrTJ6HMerEgjP2XVCaNkelZOjDsQ=;
 b=IshGGJKKIJ01Sr09LEZcO6tlasCik9U5/HfTK7dPesMHRz+w3GHQ5aJb4m8MMth/CqSsy/++9LQUmw6HqrUkEXoYjRMCjTbnkw4MTLrwQM9bBcmQj8g57dy0nj9MdV/Nrj+53tWmxBa1NmL6RYzYNEsX/ZDG9YrQ9jDoPvKvzvq4oAEP1cnwIbJLGIlaiJltInFD7rYCVJ1fEXcuaSyJf1wnTGyz0fr7VqrlQnTyhWy/1os/GErGRS3W33TfbZe88C4Zc+HCueKnMkTjbEqA0A75HRpXEjdSLp7KAldQrWKXVT0801MElSmEQsGWIVg5zpt1nCQ+lUKH57Saf/1xXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIv1hf7Mm6pmH06BrTJ6HMerEgjP2XVCaNkelZOjDsQ=;
 b=Z3BJObMAfkV9s1ZanLEoNIayn0rrVONA8wJV/rB6Diqc4jRW8FmpiKPtTQGe2I+M3Lkdr7VgIvl/QtNjxH3+0c98PDMyhLTD/X2g5X9YiKTUboBSdHi+5II9xXvqKpNq1iRTFAG2zGc3ASrmv3pP44uSWMc2qOSlhjF+hqwxBu0=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM6PR10MB2618.namprd10.prod.outlook.com (2603:10b6:5:ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Sat, 26 Mar
 2022 06:31:36 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336%7]) with mapi id 15.20.5102.017; Sat, 26 Mar 2022
 06:31:36 +0000
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
Subject: Re: [PATCH v6 4/6] dax: add DAX_RECOVERY flag and .recovery_write
 dev_pgmap_ops
Thread-Topic: [PATCH v6 4/6] dax: add DAX_RECOVERY flag and .recovery_write
 dev_pgmap_ops
Thread-Index: AQHYO1qr0XYuk2dPyEaDqgStF1AJhKzLIC0AgADrq4CAAG/9AIAEw72A
Date:   Sat, 26 Mar 2022 06:31:36 +0000
Message-ID: <a904fae9-68ce-6035-8aa2-5d43a3882d79@oracle.com>
References: <20220319062833.3136528-1-jane.chu@oracle.com>
 <20220319062833.3136528-5-jane.chu@oracle.com>
 <YjmQdJdOWUr2IYIP@infradead.org>
 <3dabd58b-70f2-12af-419f-a7dfc07fbb1c@oracle.com>
 <Yjq0FspfsLrN/mrx@infradead.org>
In-Reply-To: <Yjq0FspfsLrN/mrx@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a414cb8a-5c54-441e-911e-08da0ef2471f
x-ms-traffictypediagnostic: DM6PR10MB2618:EE_
x-microsoft-antispam-prvs: <DM6PR10MB26184AED5534BAF5E4AC5AA1F31B9@DM6PR10MB2618.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PW2FJJ4XTr7zI5m+q7uHkmcO/7rzRmw/DK1fyH7eTfrF4GxgdAuYehDtxdnTk+AAnSayt2PM7L5eyXBpzXrH4V4zZaNn6HFCD8zwOABTwt2nXJAWW/4gnkCjpmiUjTKoou5cSfIseI+kOTBxOc3YB0seCYh7kXyvVmqoVGXFCq9MBORiK2fNdSOfV5th03eE2h6kcqIjiYBfH79QbPRU8Wavn5s7UuN7dCb92L4XiFkpd7sLU8tIgxOy7N2uWH+eR5/ooeRBfjn2YRZetZj07/eA52ou5He5wrI9FXlHYVGG65//i5C76bWrYlC4C7PiNVvWbUdfERqFIpps78RGt9HVloBLXUt653POtakMuySs/AwKFMjryYyvv1oZL7V9wFDlPdCiNHLykBYFMS4RY+lfimKxwlKxHWYf4i8m/MwVBIMeZq1NS9TyiBUL/46SAPX1r8BDn8/b2lmjESPhvUyoENZlEGM69iZFJG0li4WpKijMlv0ejAFrHVGynFmZUBlpo8+wcIzN58borCopQKvslH7TcmLlA9GCgzqCcbN28EjZKI4Zzb4N4qilFjnozBwOw5ZLA85WNJew34ydnPEdrvMs2ji525H5fsFFcnDkRuLIhV2ge6pqlRta8Gfr7ikf1ZNgDclFVSEqneWP+dnt/OOFMgaqTWMYi/Sz37iLCmSSf0ahZSyA7dkRxWhZlAtxYlwvO6569OimNmSWIPSdPz+fKt2qtcEMqminNxzXcp7xerxAt5Ykmk3dB0hEbaMj2C1oMaIRxhaFmHLJNoPrk5eV4+lwUvpKhV+uUF/6YzEdZMGXYF3Nnq//mixPtR23evT9s2y7UwSeZ7ou8ciG9UYDdPLxch9xkH05P48WagmpO7H+X44AtqSwokUo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66446008)(66946007)(64756008)(66476007)(4326008)(8676002)(6486002)(91956017)(83380400001)(186003)(44832011)(6506007)(26005)(508600001)(86362001)(6512007)(2906002)(53546011)(31696002)(2616005)(76116006)(5660300002)(8936002)(38100700002)(6916009)(54906003)(966005)(7416002)(122000001)(36756003)(71200400001)(316002)(31686004)(38070700005)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEZ4bUxUckJxN2g0YkNPdEVqZlBRbEJOTzErcm5Mc2tyd1UvcXpjWHFCT0Rq?=
 =?utf-8?B?VnBId3FZY21BSTVsT0NXbVpKcUc5aUU4TFptbGMybU1QSEhjcWt5MzU4YmpR?=
 =?utf-8?B?UGZTdnBtMjQzTXE5cldXWDArVHlsTEdRSWVvZ20zeWxuRzJvRS8xQXhNNTM0?=
 =?utf-8?B?SkFjTDNDRzVhNHZFNmg5YmtGZGIrUE5JMnpWNlhDajNxZmJ1U0NTM3hqTlhU?=
 =?utf-8?B?YVRrTnJ1YkxCT2puSWprOXlBZVkzMGF4ZWFESXU4UFYyY3N3ZWw5WnFmbTRW?=
 =?utf-8?B?M1NwZ3ZleWk2K2dZRW5zdDhaZWZvZk5BWWsramlBQU94MDJ2MGtneFhsMklu?=
 =?utf-8?B?TXpxMGRrMHR2MTVoeVU5Y0ZlS2xGc2JrdDIrQ3NDQkFWSjZxMzg5aWdSRWx6?=
 =?utf-8?B?eEF2bys3dGlhUDl1R2tDK281UzgvcjQ4a1BCVkJWL0RtK1V0NW91TDZKTVRn?=
 =?utf-8?B?b3VwYWVlMUQ2blMwZjczeGM4VnBiL1ZnazNxRzAzdVRVV0hNaU8vWkJ2dW8w?=
 =?utf-8?B?b3JSVGdQbFArTnNtVDNXcTY2aS8zZ3VDMlN1VE85NGdFamJqdzMxMmd3VVFi?=
 =?utf-8?B?Z1BScG45aTZNS1BISWc1eHVWQklxOGJEWll4K1BNWjF6WHlWU0VWazE5Yyti?=
 =?utf-8?B?aEovMXpIc1JpQ3FacGhMWmthbldtUEEvcGRGRzNvMG4vYUVPa3ZUam5NOU9x?=
 =?utf-8?B?MjN3NnlPRytDYk5sTGNxZU1OMlRUSnROOWZINDNXQ3FlemNrT2daZVZxQ1JO?=
 =?utf-8?B?TTlUWUwzVTB1VXJDVHd5R3ZMRVRsU2RrNVhPNEdhdDJic0VTcU52MXM2d2wz?=
 =?utf-8?B?YzBnT1o3aXJCWmZpSFB1OG1pWjNLZ3hxWDUxRGxLdHkvd1pnbUI3cWR4WUFP?=
 =?utf-8?B?UVJGRkVhMVlzVjBOY2M3amUwZnkvV1VPaG9LUS82b0lIYWhuQ00vQXNGaDFu?=
 =?utf-8?B?TjZ5Z05yaWtaQVNsTERpdmd2VTVxRmhWalBLK2VCaHM0ZFo4cW9tTGQyN3I1?=
 =?utf-8?B?M0pzRitvSWhBd0JRRCswd0xhczRjNThIZ0ZuRldQNVBmWW41dXdLaHVCTUd6?=
 =?utf-8?B?Q0haRWZ5c0RYVDIvVjVpcHhCSnBhVisrSFlUQzZhdnVCMmlnZEF3K0RZNVJV?=
 =?utf-8?B?Y1psbW43NVh6c1R2dVpvN2dNazh4dDJqT2ZRZ1owejFCOFo5aTgwTnF6UlZn?=
 =?utf-8?B?TDFVT0poTnpuL3ZrWi9UQ2FXaVduRkR1QXdpZDZqbWxiaXlQTjlYeW01U1NI?=
 =?utf-8?B?TXdvUjE0NUgrREozUHlMUThQSDQ5UmIwQ3RHdnVjQmVHSlIxdHdRcCtLNS9q?=
 =?utf-8?B?SVM1RFdQNGVUN1hjNDF1cEdWRis4TVYzeDRWL040NTJvN2lxanVDQzh6ZkJZ?=
 =?utf-8?B?UWlVTWlseVZEeWYzNmYxVWJrSC9yNjdFanYrVE51N1pqRThVR3A0TmlFbXc2?=
 =?utf-8?B?bHFyVitHQmdkUUtpaDc5RXpJTXVjRDZaQ3doOGZjVWZLUHRyc29aWHFlQVVH?=
 =?utf-8?B?VVQ2SXFVUFpjTUE0NEw1SUlhRSs5eFpHK2doSGZSeE5qb2VPVkZvWUhQUGRB?=
 =?utf-8?B?ZzlmSWhjc0E2QnFZUmt6ZFR5WE00bktSTXQvU01SRkNEazUxSllUaGUxTEUw?=
 =?utf-8?B?c0t5dVFYSEZSS1dFZGw1U291SGVBRXIvd0xDMXJycEVXZ1NBU0xpM0NZZUxq?=
 =?utf-8?B?cGlmVUFGWlNITmxKRVZjY0dzODJnVVdHK2NWWEVrMDlmVllPTFhidGdadkMx?=
 =?utf-8?B?dzZNa2JGWTR5ZkVXLzZLRzNIVHlnTC9sRjltMnk5MzZCUlpMQ3RtcmpMR0dS?=
 =?utf-8?B?cXJlUTYrd3I4VjRHYzcrak94eEhqUFVnSmFENDNVRHZ0cHhvcHQzYTVlUFNR?=
 =?utf-8?B?TVNvRlVFTUtnQnhHMUh3VlNiNmdkczlvd1ozdWV1Rk9nM1ZDQ1FwRFYya0Rq?=
 =?utf-8?B?YWdNZTlIL2pKNWNaUXR6VVYreTdLOTdkQTVaWkNPLzQvY0VVNHZnRHl2V3ho?=
 =?utf-8?B?TWNQY0VoaTlPRElKdnlyL01CT29ZZUMzVFNJNXc3cFZKOTNmL1RWKzkzRWJH?=
 =?utf-8?B?empWUThzRjQrcm9OY0toL1BZb3RxLzREOU9yaWpjUktYQlFWd1hmbjRZODg4?=
 =?utf-8?B?bUVNSk42NjJtczltNW1kYXV0OFZaeHJDTFZ6cytoU0xHRjRIejkrZFFscUhK?=
 =?utf-8?B?bnRtWXduc2QxYnNkcmxhNFJ1U0NmZlBCNm5jSDlkY3pKVkdOV0J3YWRaMFFr?=
 =?utf-8?B?UEJKT0tYNkoxbmtoQW92b1I0ZXhETkJDSUhGNktBWG1OcGw3ekRiNVppQjhV?=
 =?utf-8?Q?If1mlzs3xLp3c53c0z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <029A55B7B30600478DC6D8E5DF8DB447@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a414cb8a-5c54-441e-911e-08da0ef2471f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2022 06:31:36.3379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pd6FBlwWV0I3snWcZw9TqjJ2U8GOLVniKFJlKxbPw5Rm6J9gfoxltvSzYutVUoUx5o21Db46l957TsejMwQYGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2618
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10297 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203260040
X-Proofpoint-ORIG-GUID: bMEH5HttZkKQc6uQJlmMP5bciMKjeW90
X-Proofpoint-GUID: bMEH5HttZkKQc6uQJlmMP5bciMKjeW90
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMy8yMi8yMDIyIDEwOjQ1IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gVHVl
LCBNYXIgMjIsIDIwMjIgYXQgMTE6MDU6MDlQTSArMDAwMCwgSmFuZSBDaHUgd3JvdGU6DQo+Pj4g
VGhpcyBEQVhfUkVDT1ZFUlkgZG9lc24ndCBhY3R1YWxseSBzZWVtIHRvIGJlIHVzZWQgYW55d2hl
cmUgaGVyZSBvcg0KPj4+IGluIHRoZSBzdWJzZXF1ZW50IHBhdGNoZXMuICBEaWQgSSBtaXNzIHNv
bWV0aGluZz8NCj4+DQo+PiBkYXhfaW9tYXBfaXRlcigpIHVzZXMgdGhlIGZsYWcgaW4gdGhlIHNh
bWUgcGF0Y2gsDQo+PiArICAgICAgICAgICAgICAgaWYgKChtYXBfbGVuID09IC1FSU8pICYmIChp
b3ZfaXRlcl9ydyhpdGVyKSA9PSBXUklURSkpIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAg
IGZsYWdzIHw9IERBWF9SRUNPVkVSWTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIG1hcF9s
ZW4gPSBkYXhfZGlyZWN0X2FjY2VzcyhkYXhfZGV2LCBwZ29mZiwgbnJwZywNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZsYWdzLCAma2FkZHIsIE5V
TEwpOw0KPiANCj4gWWVzLCBpdCBwYXNzZXMgaXQgb24gdG8gZGF4X2RpcmVjdF9hY2Nlc3MsIGFu
ZCBkYXhfZGlyZWN0X2FjY2VzcyBwYXNzZXMNCj4gaXQgb250byAtPmRpcmVjdF9hY2Nlc3MuICBC
dXQgbm90aGluZyBpbiB0aGlzIHNlcmllcyBhY3R1YWxseSBjaGVja3MNCj4gZm9yIGl0IGFzIGZh
ciBhcyBJIGNhbiB0ZWxsLg0KPiANCj4+Pj4gQWxzbyBpbnRyb2R1Y2UgYSBuZXcgZGV2X3BhZ2Vt
YXBfb3BzIC5yZWNvdmVyeV93cml0ZSBmdW5jdGlvbi4NCj4+Pj4gVGhlIGZ1bmN0aW9uIGlzIGFw
cGxpY2FibGUgdG8gRlNEQVggZGV2aWNlIG9ubHkuIFRoZSBkZXZpY2UNCj4+Pj4gcGFnZSBiYWNr
ZW5kIGRyaXZlciBwcm92aWRlcyAucmVjb3Zlcnlfd3JpdGUgZnVuY3Rpb24gaWYgdGhlDQo+Pj4+
IGRldmljZSBoYXMgdW5kZXJseWluZyBtZWNoYW5pc20gdG8gY2xlYXIgdGhlIHVuY29ycmVjdGFi
bGUNCj4+Pj4gZXJyb3JzIG9uIHRoZSBmbHkuDQo+Pj4NCj4+PiBXaHkgaXMgdGhpcyBub3QgaW4g
c3RydWN0IGRheF9vcGVyYXRpb25zPw0KPj4NCj4+IFBlciBEYW4ncyBjb21tZW50cyB0byB0aGUg
djUgc2VyaWVzLCBhZGRpbmcgLnJlY292ZXJ5X3dyaXRlIHRvDQo+PiBkYXhfb3BlcmF0aW9ucyBj
YXVzZXMgYSBudW1iZXIgb2YgdHJpdmlhbCBkbSB0YXJnZXRzIGNoYW5nZXMuDQo+PiBEYW4gc3Vn
Z2VzdGVkIHRoYXQgYWRkaW5nIC5yZWNvdmVyeV93cml0ZSB0byBwYWdlbWFwX29wcyBjb3VsZA0K
Pj4gY3V0IHNob3J0IHRoZSBsb2dpc3RpY3Mgb2YgZmlndXJpbmcgb3V0IHdoZXRoZXIgdGhlIGRy
aXZlciBiYWNraW5nDQo+PiB1cCBhIHBhZ2UgaXMgaW5kZWVkIGNhcGFibGUgb2YgY2xlYXJpbmcg
cG9pc29uLiBQbGVhc2Ugc2VlDQo+PiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMi8yLzQvMzEN
Cj4gDQo+IEJ1dCBhdCBsZWFzdCBpbiB0aGlzIHNlcmllcyB0aGVyZSBpcyAgMToxIGFzc29jaWF0
aW9uIGJldHdlZW4gdGhlDQo+IHBnbWFwIGFuZCB0aGUgZGF4X2RldmljZSBzbyB0aGF0IHNjaGVt
ZSB3b24ndCB3b3JrLiAgIEl0IHdvdWxkDQo+IGhhdmUgdG8gbG9va3VwIHRoZSBwZ21hcCBiYXNl
ZCBvbiB0aGUgcmV0dXJuIHBoeXNpY2FsIGFkZHJlc3MgZnJvbQ0KPiBkYXhfZGlyZWN0X2FjY2Vz
cy4gIFdoaWNoIHNvdW5kcyBtb3JlIGNvbXBsaWNhdGVkIHRoYW4ganVzdCBhZGRpbmcNCj4gdGhl
IChhbm5veWluZykgYm9pbGVycGxhdGUgY29kZSB0byBETS4NCj4gDQoNCkdldHRpbmcgZGF4X2Rp
cmVjdF9hY2Nlc3MgdG8gcmV0dXJuIHBmbiBzZWVtcyBzdHJhaWdodCBmb3J3YXJkLA0Kd2hhdCBk
byB5b3UgdGhpbmsgb2YgYmVsb3cgY2hhbmdlPw0KDQotLS0gYS9kcml2ZXJzL2RheC9zdXBlci5j
DQorKysgYi9kcml2ZXJzL2RheC9zdXBlci5jDQpAQCAtMTk1LDEwICsxOTUsMTAgQEAgaW50IGRh
eF96ZXJvX3BhZ2VfcmFuZ2Uoc3RydWN0IGRheF9kZXZpY2UgDQoqZGF4X2RldiwgcGdvZmZfdCBw
Z29mZiwNCiAgfQ0KICBFWFBPUlRfU1lNQk9MX0dQTChkYXhfemVyb19wYWdlX3JhbmdlKTsNCg0K
LXNpemVfdCBkYXhfcmVjb3Zlcnlfd3JpdGUoc3RydWN0IGRheF9kZXZpY2UgKmRheF9kZXYsIHBn
b2ZmX3QgcGdvZmYsDQorc2l6ZV90IGRheF9yZWNvdmVyeV93cml0ZShzdHJ1Y3QgZGF4X2Rldmlj
ZSAqZGF4X2RldiwgcGdvZmZfdCBwZ29mZiwgDQpwZm5fdCBwZm4sDQogICAgICAgICAgICAgICAg
IHZvaWQgKmFkZHIsIHNpemVfdCBieXRlcywgc3RydWN0IGlvdl9pdGVyICppdGVyKQ0KICB7DQot
ICAgICAgIHN0cnVjdCBkZXZfcGFnZW1hcCAqcGdtYXAgPSBkYXhfZGV2LT5wZ21hcDsNCisgICAg
ICAgc3RydWN0IGRldl9wYWdlbWFwICpwZ21hcCA9IGdldF9kZXZfcGFnZW1hcChwZm5fdF90b19w
Zm4ocGZuKSwgDQpOVUxMKTsNCg0KICAgICAgICAgaWYgKCFwZ21hcCB8fCAhcGdtYXAtPm9wcy0+
cmVjb3Zlcnlfd3JpdGUpDQogICAgICAgICAgICAgICAgIHJldHVybiAtRUlPOw0KDQoNCi0tLSBh
L2ZzL2RheC5jDQorKysgYi9mcy9kYXguYw0KQEAgLTEyNDMsNiArMTI0Myw3IEBAIHN0YXRpYyBs
b2ZmX3QgZGF4X2lvbWFwX2l0ZXIoY29uc3Qgc3RydWN0IA0KaW9tYXBfaXRlciAqaW9taSwNCiAg
ICAgICAgICAgICAgICAgaW50IGZsYWdzLCByZWNvdjsNCiAgICAgICAgICAgICAgICAgdm9pZCAq
a2FkZHI7DQogICAgICAgICAgICAgICAgIGxvbmcgbnJwZzsNCisgICAgICAgICAgICAgICBwZm5f
dCBwZm47DQoNCiAgICAgICAgICAgICAgICAgaWYgKGZhdGFsX3NpZ25hbF9wZW5kaW5nKGN1cnJl
bnQpKSB7DQogICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVJTlRSOw0KQEAgLTEyNTcs
NyArMTI1OCw3IEBAIHN0YXRpYyBsb2ZmX3QgZGF4X2lvbWFwX2l0ZXIoY29uc3Qgc3RydWN0IA0K
aW9tYXBfaXRlciAqaW9taSwNCiAgICAgICAgICAgICAgICAgaWYgKChtYXBfbGVuID09IC1FSU8p
ICYmIChpb3ZfaXRlcl9ydyhpdGVyKSA9PSBXUklURSkpIHsNCiAgICAgICAgICAgICAgICAgICAg
ICAgICBmbGFncyB8PSBEQVhfUkVDT1ZFUlk7DQogICAgICAgICAgICAgICAgICAgICAgICAgbWFw
X2xlbiA9IGRheF9kaXJlY3RfYWNjZXNzKGRheF9kZXYsIHBnb2ZmLCBucnBnLA0KLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmxhZ3MsICZrYWRkciwgTlVM
TCk7DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmbGFn
cywgJmthZGRyLCAmcGZuKTsNCiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAobWFwX2xlbiA+
IDApDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWNvdisrOw0KICAgICAgICAg
ICAgICAgICB9DQpAQCAtMTI3Myw3ICsxMjc0LDcgQEAgc3RhdGljIGxvZmZfdCBkYXhfaW9tYXBf
aXRlcihjb25zdCBzdHJ1Y3QgDQppb21hcF9pdGVyICppb21pLA0KICAgICAgICAgICAgICAgICAg
ICAgICAgIG1hcF9sZW4gPSBlbmQgLSBwb3M7DQoNCiAgICAgICAgICAgICAgICAgaWYgKHJlY292
KQ0KLSAgICAgICAgICAgICAgICAgICAgICAgeGZlciA9IGRheF9yZWNvdmVyeV93cml0ZShkYXhf
ZGV2LCBwZ29mZiwga2FkZHIsDQorICAgICAgICAgICAgICAgICAgICAgICB4ZmVyID0gZGF4X3Jl
Y292ZXJ5X3dyaXRlKGRheF9kZXYsIHBnb2ZmLCBwZm4sIA0Ka2FkZHIsDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hcF9sZW4sIGl0ZXIpOw0KICAgICAgICAgICAg
ICAgICBlbHNlIGlmIChpb3ZfaXRlcl9ydyhpdGVyKSA9PSBXUklURSkNCiAgICAgICAgICAgICAg
ICAgICAgICAgICB4ZmVyID0gZGF4X2NvcHlfZnJvbV9pdGVyKGRheF9kZXYsIHBnb2ZmLCBrYWRk
ciwNCg0KDQp0aGFua3MhDQotamFuZQ0K
