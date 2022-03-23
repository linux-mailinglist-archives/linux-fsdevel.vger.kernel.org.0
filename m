Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60484E589E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 19:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343971AbiCWSpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 14:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343963AbiCWSpI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:45:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C52789335;
        Wed, 23 Mar 2022 11:43:35 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22NHr6uR004114;
        Wed, 23 Mar 2022 18:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kha+Sov7Lq6ghZNlZKh/2VPgdnaEwZu7Z9k29BWTZj4=;
 b=vFyOgeMJtyiWlpfi/SceAhT8zbY6MoVQGYMEY7SBz/hh7AX2l4ZrTr3rGqybGho7OZfy
 AOryZMBM4fM/KzdS7G1FUD+bsFF3zuoCTiVjYY+TGK0Yrtom9VlYBVN/Flg9HwAlRU6P
 elbJcDc16L6lEI6kJoSqM1f8scradEwnRJK1o2KnDT34BbAqOG1z/dbmUIjfcRqCRJ3Y
 jVUGgna3b7lvQXwe2Bosc9wmZAj3eVei+Y9q+dIuLpc290TP0DXCTBThdkZDxyPDOgRl
 d0EnEahH5zM9HXWgluYFwjH1DO4cMp3xliYtyZ8IXGZhkOAG5T2KemBSn6LJBHFZECwB HQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5y22f98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Mar 2022 18:43:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22NIf7R5183175;
        Wed, 23 Mar 2022 18:43:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3020.oracle.com with ESMTP id 3ew701pw79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Mar 2022 18:43:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Al+BW1y3mIvRvTpSQUvIA6Q/5D3RfHYUEi/iYMDbyKUQQDF49ClH3SX77Ydtn3VwUNvgJcPUYRunOkVHwAH8A590xt2ck+jLKD67ANeRk9/yeLOR/ZmvUNWYzZKc+t94379IU4XGqhsAB0s9kUIPrCpqXNeWAETGb5JVSlVZkd0XI5Ef8FeHH2ywNJV5Nev7Nh9PexmEONLotFNxqF7ZTVBXULB1J18cDKmtfHiqU+6Re+G29bKv3ZNqgIa7UEgxN/4vfKZQNcstvfYEyKu+JXD7QdhSw6sM6mRyERVkSV1uAPGSKeVsRPLx9o0cHGu/Q0M/Rss3fIzHNQxfkIU8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kha+Sov7Lq6ghZNlZKh/2VPgdnaEwZu7Z9k29BWTZj4=;
 b=RNGbaX/eeZWg6gdebQX4vJWo7LgYzv2aldCPxd5la2o1dyc+DgYyuK3ewb5HTAZ3b7US9d3SuKCYRy3w6Jl/OhJ9J3slU8HGqj0D7S8XH9gjqVqaHE15k70J6yZrxvfI3cSNxNe+AdXazUM3H02m/J0pDWQq+uLBDKggjKvcjkPpBExHnhK8XEGOYQa2SK2cN7E/CJy2MSGVpkImLRs02z9xHcpBTw+X7S+DFk67uOinfCHmQfcofnkNadZQRBIv8WkcuLgCQKrl9LbrDaLw9BTbJzUJvQw2rHl5n0KxB2d9x1PgYx+sOiu63k/tcjLGdbxyNgo3Wx/cLXD//8qZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kha+Sov7Lq6ghZNlZKh/2VPgdnaEwZu7Z9k29BWTZj4=;
 b=sb9z8UP5pcKcXtQHU38S+0hKyzl0LHcxs7FWjzVafZHartTlQJ5ra4V4XtG41J8x/sD6og9LsMUgtr8e3tZ+smdaA82lf852pfERgvnR8YFWqcHAFf+mRsFhLDTldmKYmkEdXP9pmNzsdOTF/yz8fzeJip7HC7s9arFwwk60qbw=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM5PR10MB1481.namprd10.prod.outlook.com (2603:10b6:3:9::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.18; Wed, 23 Mar 2022 18:43:07 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336%7]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 18:43:06 +0000
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
Thread-Index: AQHYO1qr0XYuk2dPyEaDqgStF1AJhKzLIC0AgADrq4CAAG/9AIAA2SAA
Date:   Wed, 23 Mar 2022 18:43:06 +0000
Message-ID: <2897ca93-690b-72ed-751d-d0b457d3fbec@oracle.com>
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
x-ms-office365-filtering-correlation-id: 36aa46f6-0b6a-4e2a-7fca-08da0cfcf8a8
x-ms-traffictypediagnostic: DM5PR10MB1481:EE_
x-microsoft-antispam-prvs: <DM5PR10MB148194C88B87C00180A081F0F3189@DM5PR10MB1481.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: umPTFNbuJbnAF6x6VwU92Glutd9+hBRfwsapvHjCilYkk8cBrD8EV82YTyxsLmx9gZXV69UAUQWPicuB9mDB2NP3vvDouk2kr6kC5OMnfsgvdQ5KSZw8+aAaKIBCiKMVdwtyk4EU04dXlhb/+owELjA54W9i1ckcZ73WES7RkS995aYSTrMF0OPEXnx03+1ZzSpPWCUT5TP/ZGoD+AWifd9ZRVGvgTJKJkc4G9JMFJGjzJWEisar+oUvUx1PY3pDaSuucIthrqsdPs+9v3VP8e+RbasJ8/TY6ahfjI0A383H8Do30M9K3ERt8Od4eJnMwvc/vEga2oP4LBaCKxg8QZXMCIFaQ6to2Sx6YURB6njTZsTgn51LEuqrIzvJPMovDhrrZwd44kTnHHLJZA1SBKRfjyGWS98oWWNB9FuJq1GFOHySPITAQfTMzME1IWgT1WSDt95vxCuWpCds0eSdT52+lGqhKwlC5164p+6i+QkEXTHpDWtdFQVXmWFD4DqvNkJUVdtKuybD+LSC1CIUJ2hVpWIcJoRd/0ubFlJSuOMEb/+/yT/AVL2JNzav/EZlT4uCgMlDGD+Zn43cipjUXa6iha1l3QU4FZfVjsFfHMMgZtf1Body23Qp188wx0ML0PaP8VlLH3JOSmv9frBMBopd7T3rtMNEznwsltj+MYKAEBE/deAfkKxuOiOisgaymQyIhoBG57YE6izVXwi26bG5k69nhgXi0KRtBR+jS8olmYY9/OuFybU4blXiQMRzTUyXd/bd8WRNAOiY03R3dveKsSO+hul+qLJTBxdl2tYvJ2O9820D3iJ5PglQgKHNk5nxgsPqq9jei7yMW+nKm3DJWZmjWVj5hPdS26/qtaRYEg+RHOAwJuKPrQ2pOm1H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66476007)(66556008)(66946007)(86362001)(76116006)(66446008)(64756008)(36756003)(2616005)(508600001)(71200400001)(5660300002)(966005)(6486002)(6916009)(53546011)(316002)(31686004)(6512007)(6506007)(54906003)(186003)(26005)(83380400001)(8936002)(31696002)(7416002)(44832011)(2906002)(38070700005)(122000001)(38100700002)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0wveG1PS3A0MnBESFJUTEpkWUwvWlZqU1ZPZ0RraHUwdmloc3FESjlMQkZW?=
 =?utf-8?B?NXpUTEt1MWxFVy9icTFmb1A4OXBUb2c0UEZSbjJPdmlBZHZDUUhuaVJsRHpN?=
 =?utf-8?B?TWtvVUFaMldLS3VrTGQrZE5lMG1OQ0NYaVZFRkNHOEF3NENoRlZiaEltVm5a?=
 =?utf-8?B?djU5RUMyd1RhZUpmaGVEQjFDVkJXNnlxY0UxSVAwWmJyc2wyOEZDMHAwQ0h0?=
 =?utf-8?B?SnlCMkNkQnRCaHY0L1Z4em8yZWQvNXpUYmlsOTdsNERlNVFyeVkveDF6enJz?=
 =?utf-8?B?UUIrS1FhV2pBQmY2b09lWmlpdzdJVzV3OXJuTEVrdHRUZUZla3FwODVGOXgv?=
 =?utf-8?B?aHgrdXU1M0hNamNKd2loYmxibkU2dVlvM0Uyb1RuQTB6VzFWMnpyVHpZUGlW?=
 =?utf-8?B?cnIvekNNbkNIZUMxNk8yWEd0RitLZXI0aGFUMjFUVGoxcHNucm5kZWVCVE1k?=
 =?utf-8?B?ODlnMnFuaDlJeGNaa0swaWJMRkVUNFlZczVLZEpCUjF1cmI1d0xTb2NtSUpy?=
 =?utf-8?B?RXhsbjhDOUViZmFJejJXT1NTcExFbWgzdDBKYzFHTFltMTNOekg2YkxoL1dT?=
 =?utf-8?B?eFdJWjN1ZnZYcWVnOE9CamNoWkNENzBEWmR5L2N4YkFuWnpRaXQ4M0ZRUG1X?=
 =?utf-8?B?Y05xQ3k1UmdLa3A1R3hqRTB0di9kSlN0c3dEMmM4aWh2SUpaZUhIMWkvbFNt?=
 =?utf-8?B?MFRFN1VWYWJIblpxODVEODJ4Vk1ucTBNclZLNWUxWDRnTjVHQ1A1cFdXV3NG?=
 =?utf-8?B?em9lNERwK0dvN0hjM0FlSXRsM2lSODE5TFFubjhWZ2NYMis0NWVCYi8vRXZK?=
 =?utf-8?B?bU9qV21JM0xISGhQWENJSi92ZGRZUERrNGpPY2NoeU1OdGhjVERPakVTUDJL?=
 =?utf-8?B?TElxN0RmV2RmbmZqcHVxa045U3F1ZFdqa2FYTndKTmJ5aHpaTThrb2hlVVdy?=
 =?utf-8?B?WTU3N1psbEVFWTRaeTJrUm03bmlOZDJaL01YTU13cWpOVU0yNVg2bVRhRUsz?=
 =?utf-8?B?THVZVWRoVndsMmhSdUdwVEpWRHB6SzJNN2FnbS8wTllGelQxODZFTnBqQkJL?=
 =?utf-8?B?LzVQRDlXSW9FeStFeWtjSmFpUjJuWmdERytqcVZEeWNVVXZTcFNEWDRtTUdi?=
 =?utf-8?B?SU1LZ3dlbnFkdDJINFVIUzlaZlRCZnFHRzN6QVU3TFV2Yjh5cDg3eGgyck44?=
 =?utf-8?B?SFBvTkJ3RFAvUUNtMlpTU3k0OWQ3KzNQemRQU3NvejFsSFhEbWJnMDczeEpv?=
 =?utf-8?B?RTFOWmJ2VVM4QTZWU1d4QVRxTzRFVElkM0twdFpHbmVSejlHNm5FTllQd1Nw?=
 =?utf-8?B?eFNBUmhtN1NLNnEvSW9kaElkZURlWWxRZjhBU0d4VFV1cUo3blA0Nmt1WUdR?=
 =?utf-8?B?Q0VLMEEzcTkreDg5eXV5UFZDa1FsUjlERmRsUXNJMWJYYlg0bEwwMzkxcHZJ?=
 =?utf-8?B?RnY4QXl1d1JjVXJaYXc4SHI3NWNmU0VnblcvQ0c0WlE3aDVkOVMvWFZxb0tk?=
 =?utf-8?B?T21WY0crY1hqMEFNUWRSNGdBczNCdnhMSG9MNm5uVjVWMkFwQ1VvRkVLQ2F1?=
 =?utf-8?B?VytBb3JQNXlGblRiaGphTkYwczZ0dWNxSUIyWkcrb0Rtb1lQZUM3bEljczlr?=
 =?utf-8?B?VEMyUlF5eFhoTmFaaXU3ZysrWEI3WUhPZWdaV1AxWE15ZFZtMC96YXJBUUJK?=
 =?utf-8?B?UGRrNWRVSFVaREJYWTRtTnpiYklQcStKQWU1cGZyNlV2dzhIajQwc2EraGI3?=
 =?utf-8?B?WFEwMC9FRzZlRkpSSmJvNDdWTnpMQ3g4elQza1Foa3hmaVI2M1lkTXVneitL?=
 =?utf-8?B?TmZzcGVUSHlQOFdEWFVJYmQvYkd3ZG9VclVRY0I5a29hTTZydFllbTlJZFpO?=
 =?utf-8?B?aGdRQmM1UkpXa1lUSUhqTFU4OGI4ODlEYk1yYVJwSXhwTHBvYVVvRDB0Q1ZF?=
 =?utf-8?Q?SL5iwCOhvt8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73969C9FD7DAC94F8ED6B7FBD409F573@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36aa46f6-0b6a-4e2a-7fca-08da0cfcf8a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 18:43:06.8337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WbV7RVNpjvzgtfeN5wjBsAcKsVRRWgtvT90qu9gVIW+/E3+LCU/MXCo3FJxw+xgiury301q7KLlRplEWYgfFDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1481
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10295 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=878 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203230098
X-Proofpoint-GUID: hjjHGXr6HSA6N0p88bNGHy3fW6sykkEX
X-Proofpoint-ORIG-GUID: hjjHGXr6HSA6N0p88bNGHy3fW6sykkEX
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
ciBhcyBJIGNhbiB0ZWxsLg0KDQpUaGUgZmxhZyBpcyBjaGVja2VkIGhlcmUsIGFnYWluLCBJJ2xs
IHNwZWxsIG91dCB0aGUgZmxhZyByYXRoZXIgdGhhbiANCnVzaW5nIGl0IGFzIGEgYm9vbGVhbi4N
Cg0KICBfX3dlYWsgbG9uZyBfX3BtZW1fZGlyZWN0X2FjY2VzcyhzdHJ1Y3QgcG1lbV9kZXZpY2Ug
KnBtZW0sIHBnb2ZmX3QgcGdvZmYsDQotCQlsb25nIG5yX3BhZ2VzLCB2b2lkICoqa2FkZHIsIHBm
bl90ICpwZm4pDQorCQlsb25nIG5yX3BhZ2VzLCBpbnQgZmxhZ3MsIHZvaWQgKiprYWRkciwgcGZu
X3QgKnBmbikNCiAgew0KICAJcmVzb3VyY2Vfc2l6ZV90IG9mZnNldCA9IFBGTl9QSFlTKHBnb2Zm
KSArIHBtZW0tPmRhdGFfb2Zmc2V0Ow0KDQotCWlmICh1bmxpa2VseShpc19iYWRfcG1lbSgmcG1l
bS0+YmIsIFBGTl9QSFlTKHBnb2ZmKSAvIDUxMiwNCisJaWYgKCFmbGFncyAmJiB1bmxpa2VseShp
c19iYWRfcG1lbSgmcG1lbS0+YmIsIFBGTl9QSFlTKHBnb2ZmKSAvIDUxMiwNCiAgCQkJCQlQRk5f
UEhZUyhucl9wYWdlcykpKSkNCiAgCQlyZXR1cm4gLUVJTzsNCg0KPiANCj4+Pj4gQWxzbyBpbnRy
b2R1Y2UgYSBuZXcgZGV2X3BhZ2VtYXBfb3BzIC5yZWNvdmVyeV93cml0ZSBmdW5jdGlvbi4NCj4+
Pj4gVGhlIGZ1bmN0aW9uIGlzIGFwcGxpY2FibGUgdG8gRlNEQVggZGV2aWNlIG9ubHkuIFRoZSBk
ZXZpY2UNCj4+Pj4gcGFnZSBiYWNrZW5kIGRyaXZlciBwcm92aWRlcyAucmVjb3Zlcnlfd3JpdGUg
ZnVuY3Rpb24gaWYgdGhlDQo+Pj4+IGRldmljZSBoYXMgdW5kZXJseWluZyBtZWNoYW5pc20gdG8g
Y2xlYXIgdGhlIHVuY29ycmVjdGFibGUNCj4+Pj4gZXJyb3JzIG9uIHRoZSBmbHkuDQo+Pj4NCj4+
PiBXaHkgaXMgdGhpcyBub3QgaW4gc3RydWN0IGRheF9vcGVyYXRpb25zPw0KPj4NCj4+IFBlciBE
YW4ncyBjb21tZW50cyB0byB0aGUgdjUgc2VyaWVzLCBhZGRpbmcgLnJlY292ZXJ5X3dyaXRlIHRv
DQo+PiBkYXhfb3BlcmF0aW9ucyBjYXVzZXMgYSBudW1iZXIgb2YgdHJpdmlhbCBkbSB0YXJnZXRz
IGNoYW5nZXMuDQo+PiBEYW4gc3VnZ2VzdGVkIHRoYXQgYWRkaW5nIC5yZWNvdmVyeV93cml0ZSB0
byBwYWdlbWFwX29wcyBjb3VsZA0KPj4gY3V0IHNob3J0IHRoZSBsb2dpc3RpY3Mgb2YgZmlndXJp
bmcgb3V0IHdoZXRoZXIgdGhlIGRyaXZlciBiYWNraW5nDQo+PiB1cCBhIHBhZ2UgaXMgaW5kZWVk
IGNhcGFibGUgb2YgY2xlYXJpbmcgcG9pc29uLiBQbGVhc2Ugc2VlDQo+PiBodHRwczovL2xrbWwu
b3JnL2xrbWwvMjAyMi8yLzQvMzENCj4gDQo+IEJ1dCBhdCBsZWFzdCBpbiB0aGlzIHNlcmllcyB0
aGVyZSBpcyAgMToxIGFzc29jaWF0aW9uIGJldHdlZW4gdGhlDQo+IHBnbWFwIGFuZCB0aGUgZGF4
X2RldmljZSBzbyB0aGF0IHNjaGVtZSB3b24ndCB3b3JrLiAgIEl0IHdvdWxkDQo+IGhhdmUgdG8g
bG9va3VwIHRoZSBwZ21hcCBiYXNlZCBvbiB0aGUgcmV0dXJuIHBoeXNpY2FsIGFkZHJlc3MgZnJv
bQ0KPiBkYXhfZGlyZWN0X2FjY2Vzcy4gIFdoaWNoIHNvdW5kcyBtb3JlIGNvbXBsaWNhdGVkIHRo
YW4ganVzdCBhZGRpbmcNCj4gdGhlIChhbm5veWluZykgYm9pbGVycGxhdGUgY29kZSB0byBETS4N
Cj4gDQoNClllcywgZ29vZCBwb2ludCEgIExldCBtZSBsb29rIGludG8gdGhpcy4NCg0KPj4gaW5j
bHVkZS9saW51eC9tZW1yZW1hcC5oIGRvZXNuJ3Qga25vdyBzdHJ1Y3QgaW92X2l0ZXIgd2hpY2gg
aXMgZGVmaW5lZA0KPj4gaW4gaW5jbHVkZS9saW51eC91aW8uaCwgIHdvdWxkIHlvdSBwcmVmZXIg
dG8gYWRkaW5nIGluY2x1ZGUvbGludXgvdWlvLmgNCj4+IHRvIGluY2x1ZGUvbGludXgvbWVtcmVt
YXAuaCA/DQo+IA0KPiBBcyBpdCBpcyBub3QgZGVyZWZlbmNlcyBqdXN0IGFkZGluZyBhDQo+IA0K
PiBzdHJ1Y3QgaW92X2l0ZXI7DQo+IA0KPiBsaW5lIHRvIG1lbXJlbWFwLmggYmVsb3cgdGhlIGlu
Y2x1ZGVzIHNob3VsZCBiZSBhbGwgdGhhdCBpcyBuZWVkZWQuDQoNClN1cmUsIHdpbGwgZG8uDQoN
ClRoYW5rcyENCi1qYW5lDQo=
