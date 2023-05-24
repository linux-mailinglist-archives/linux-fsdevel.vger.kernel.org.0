Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F8F70F9D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 17:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjEXPKM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 11:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjEXPKL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 11:10:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EBA12F;
        Wed, 24 May 2023 08:10:10 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OF0TEa002345;
        Wed, 24 May 2023 15:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=WS2lBlLoawjF1ExbWsgAkbe1uh9lSakgcdjHnrfcbQs=;
 b=fnVfpot9e69ePEU9f9/D3FGtJVFzCFFQPouORRuuB6WKS2iYrFU15QkGBcgD9+qhb2LF
 N2CwPv+hmVdORNFr8eTpsPPFmg6Ca0m/nk8d94l1UUFm2rpwaL2YZE2vr5qzK8U9cwmN
 o27eYhqUXeXkA2WaIBnWAFMYmk6CHldFA/gpUfMmkAwcKB9ABrdup2cpc5chvwOwsmCQ
 tuwVwPKEkermBXUxZUYIRziVv+KVYTuxFu+mOO2qg9qDColeS1z5a+KUkdBS7x7wQjBk
 yHDehieAuAwzHZpi7nQnBGIKgeLEX1rVpNacplErVV6r3SwYZ2yyDWSgW5u7lHjcIUIm vA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qsmua01s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 15:10:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34OE6gVb015767;
        Wed, 24 May 2023 15:10:05 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk6kw51f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 15:10:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQI0xR9JCRaPtp7hEIBQblZ7d5KRhdUbg7xM5j5pWe7Wi1EzWn369AFnxchgDzCBNsN8X1UdX2R9W5CHIGhr0Vp3JvCC3I0BeFfM176Po0rd4LxOtMwkhvioGL2wWzfTtr0ER7Ty4KYw19OwSu10MW007t+NQS69pLez1kHMeUyQ6fOzFr6MHENbibUaBMzkRTAcalDzJ3+hHg87r6cTkD6fz1j/I6kba28NA8qQbWV/Cf5kVdAlAg8UMEuqYbq0sf0x9JBrJiPrwxakaSR3Qm0M8Xbwi7c5e/Wg7RQebJf1F5a+t2Wmn+zPRfkDRe/IrdYa66ddhnPRIHBDAJg4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WS2lBlLoawjF1ExbWsgAkbe1uh9lSakgcdjHnrfcbQs=;
 b=FNNa+5GH7DvHmXnE3Je/rEKuEH1dR97ddOmqIbKI1RxI8tt2FRgxDfdAiVpx472JYLxHSsdebJLu3X5F8XD7QCTYSC8rxlBllJENC7ksD3Rf5gKxxmRMKiPyel7GgRlhKrbexGOAY6YycqK6YBwo2N121kQF1lybsPhp3UH4HRQjWaRlvhaEbDuN71ymyoLQ/2//gouXkHKws7pPhbiqvdrLmL9VDsZk7l92+oRCrrXH7ow39ifX90pllO2SvNr7wYZnaReilth4X5AVh3ZJFYbKrMDTooWaAnyTooI+DysT/A5C9BdFd63mUi9iJUxy6DeBTCM5bq2gTGpmJqGdYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WS2lBlLoawjF1ExbWsgAkbe1uh9lSakgcdjHnrfcbQs=;
 b=R5ZLKZr2XP5bPqJRP/H+ZkesHpMqmURHbt7R2D2rjqTJjtMJmliSjwL8uajI5i8e1e3sS90S40MOXtdARarM5oOq4SLjVlcdFuJm102BrN7agMTWX7FuAHYfCutJDBHPdg+gVLXaPNfL+1fo+nVddzP/xgVGdlUl4AFwpIEtPTM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6056.namprd10.prod.outlook.com (2603:10b6:8:cb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Wed, 24 May 2023 15:09:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 15:09:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] locks: allow support for write delegation
Thread-Topic: [PATCH v5 3/3] locks: allow support for write delegation
Thread-Index: AQHZjQiIht0IszKu60KDnHp/yj6+RK9piRmAgAAAVAA=
Date:   Wed, 24 May 2023 15:09:44 +0000
Message-ID: <D8739068-BCAD-4E47-A2E2-1467F9DC32ED@oracle.com>
References: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
 <1684799560-31663-4-git-send-email-dai.ngo@oracle.com>
 <32e880c5f66ce8a6f343c01416fcc8b791cc1302.camel@kernel.org>
In-Reply-To: <32e880c5f66ce8a6f343c01416fcc8b791cc1302.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB6056:EE_
x-ms-office365-filtering-correlation-id: 8e2d5b29-7760-483e-56b7-08db5c68e84e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FWM+d5ip8pOoMGt7FHnsRErdqSKUPp+eDFE3GlzF3NSpe2DkORdQAX8QWuJkzx2p/KS6Qh6cQB6pAKBmtnIwhBgmn5ardT61pF4N34QTq+vHwBiuu0QeqZQIpxCDCMxUqbPDhszigmjAbYM0gGDxAm+Ah/12xo4dnCoEx7pHEEXIt8JwxachRQDgDjfMyHRm95g+JTK2yC4K2ffBN3xriQMEzh8Bet81FNhWakz56bU0Aif1mMwoj8gokhrCQcBKuNlSI/rvXRO3mA2L7AHtu/OyvI4g78XZtayVPDrYaFRApHXycUzSVlyJygXCBqVhYebQUGMcHS9r/4r1zOUAD4D7JuQ4AYaNxC299u4uvZWUivaIeIXw89u29kd8JFLoRC/VND2nQNJSLQYPlJyGFBpyUBWAAYjPBS6H3R+e7xeRjj11Ul7y5sbRZ7OGYhpP5MGsCzXR9P+rtlGK97jwxofni9BaY/XX48b18e2VGNXAD8omSdcoMj7OUCj0BFYg1YVk08YAWXLn4UvjmrCIyjU61S7D/pxtubgmjhnWGuEy7Z9kyLA/oV1m2IKfa/LfaeC3GoKqyQNTuKRrM5yORDUUNJ/WROJpIq08HA0YY1pc1UgmDs0GxRcNjsZGUj/C39wqsHmnsPe2Xnu7V7/8xQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(53546011)(122000001)(38100700002)(6486002)(71200400001)(6512007)(6506007)(26005)(186003)(33656002)(5660300002)(64756008)(4326008)(6916009)(316002)(66946007)(66556008)(66476007)(66446008)(38070700005)(41300700001)(86362001)(76116006)(2906002)(8936002)(8676002)(91956017)(83380400001)(478600001)(54906003)(2616005)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LyOZooXJlpCz4n6saDpisnV9jEmucsoL+Me/WptaH2J9Ebdgm5r6ix6oZbrM?=
 =?us-ascii?Q?iNiTWLwoEVKp/gVZjHyDvHOXq7RTkuIoLDPX97mpQgFuVjGvBPrUottWprvq?=
 =?us-ascii?Q?1OASuy5KrEz/Ys3V5ud3rWx3mRmw0/9bd5nXJ2i/5YNs2f+wxdygcTJ9//6u?=
 =?us-ascii?Q?GugH+U0t8SwYDlInFCBHijehwei6YfPPsSJagZi7sRT8LOENIosGqzc6FETn?=
 =?us-ascii?Q?hmr+U8/v848Wq1mPfEwYBVeUvCAZACxCBG9Sc4N5i7oLQS2+PTRwKMycKwyK?=
 =?us-ascii?Q?1FFKT9pC/23N1bpDhdfjZ0iheyZCYYVwfTFO3jyA9rQeLdsCtFm1C2tM0KtD?=
 =?us-ascii?Q?QnMccPAlq5C/Cm9GIN4Zp4CTsUH1zq9yX6c1gMXux/EozwIg0TQYte6UerjW?=
 =?us-ascii?Q?Z7p4kjpah2DF2rBe+UH5wgkGnH4sWz8cYZiswFaLEQrGxPSPn7QTu3Qc3P6k?=
 =?us-ascii?Q?tul0dVPHIlJ1CtxICzsOn12FJMNWshwTZjB1WTmzcWNKSo9a/gjiofs3/FuG?=
 =?us-ascii?Q?RRIWQ9OtRl842ncYe3d6SLSCDUp7FD62oVlDxRSZWT/67fPjiGDhw8oYZaoo?=
 =?us-ascii?Q?q8jufhrICnp9Q5R6fTC9iS//ZwsbVsWyYZLQuhOtB77/ITWmJBjtEgXjAA8M?=
 =?us-ascii?Q?K72NrT62oVCVW9iDxzAsgKVSMiJfcAh78kZjH6OwFSIPQ020QO6g6a+quE0J?=
 =?us-ascii?Q?1p7yVv2WlGhUs1Z9dVxz6bLIei9HNwmCm3X/YfJNAGdYYzeceAJyuIxd8K7K?=
 =?us-ascii?Q?lDzz4GksiaJrXW4FIZst+qTfHGY9sCbJReSNZYpEqTG6RQ1oHpOtULBE6EdL?=
 =?us-ascii?Q?5odiku97Xi0TrDI1yOD6n0dqs94ikpWTptfl9F6TpSUuOyf3iDcXEygSLDyX?=
 =?us-ascii?Q?HX3sR2eoew7bfsWQ3YwuBSA03yMdoJPirAu6MCw7cowXm1ZOrP14aZia7KRy?=
 =?us-ascii?Q?Z9C6cY/Zg3H9eUCVP+KBlk4WA9PvsMx7kNnbBDlXSgf257duiO4yymltqVUh?=
 =?us-ascii?Q?v2vGKj4FDmAwIM7Wt+S04WQblHnMS8aiQSq305cT7aZIJAfDc/GPPcqAnCA2?=
 =?us-ascii?Q?n5pjQ2xOxF8UG/J3ZI8VLqNJSS5hp7MjQg4ugMkmOaZh5C6e6WV24o4jpyLQ?=
 =?us-ascii?Q?FAekcSvtUwwnvbzsFLEJA6bjdpottA3hrwtqaNHsMqjvg87tzj9Y3pELeay1?=
 =?us-ascii?Q?a1/UT+045BZ4DwmPHKGaxnsXxvqOBkVHh/AwCZXe6tBejV+vnEwBtueYKA3g?=
 =?us-ascii?Q?M+ijZt+rV/ITq7uZK3NZV7eRRbowocHeZiM1EefECMz0ZUMd/0hX0RGLVIdv?=
 =?us-ascii?Q?0Z0UtArz/OxwQWjqzQMxfI9qVm/+PHOxIaQ0cM3HladSIejRYCgL3y9gb90o?=
 =?us-ascii?Q?iBScZ8aaYmHA9TDLCb95syrfy5kY6mvj6F2gAghRef429UT7WpkRcqDAcjhg?=
 =?us-ascii?Q?8knlgVOgol/ri3DbcElpXmVHd2fyH/qhLXSvKBmEyiCJakQp4UT3pgcnNL6E?=
 =?us-ascii?Q?NBxhVfBc4d8ELONxh5kY+vXM/jiRcWLml/FC7aJUpE6tX9HY7dzjAW5CANCX?=
 =?us-ascii?Q?P+rjvgkt0PvmoFP/kMXlAnAoO4pDx/NSizqSkxBpR2aKM81eBNcYQECDEKp1?=
 =?us-ascii?Q?Kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F9B0D8CAEB35E4E8A35658BB8EF050A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0R2ttkTztp28u4DoStfH3B8lUj1SYb1s2AE8MhNw9EsHPkpyYoJcsfP3hhQhhTOQXCY/WmLOX3zGytd/QBc3IUQkhU8BdaSty1/qDRq7ilI0tPFYvmfDQTnzblGsqA5nSY+uKC1FigmY6Onj8qOfFPnmdGtQrm9mzXRPHP0Y0T4aGTVVAZ4wJWfyrsVBTKnSWPH98kf9FF9oVNOmyZivx/h/sYTNerPcxctZiiSsweEJxSiMjHrpS5pWXYRm2m9pbqeSb2jhR3kA9iGe5TnidBKkxwVUkLfAuF9Hfvwc0W30AHmDR6fgTXqXeGQZpgswd2Cg5geVwH2fkdlZ7l3twdkK+fOIV3j5P2JowtzqgSBXId+1ADJiML7Vh8UWh9WxOdAoZihAtgtWbjDYdoEP/yry89d9Moyc9BiaNRc4Z5aHPv1OK/im95h6G843mQB/UMpRYyN3Kg3caWU2qn/fT7c9Bkgh3ELD3tlHhMy2/7QnXJ1td5EdyDXtl9C/cAyG0V3+ewGoglTIpvVU+iN+DRdyBdewIk6TwlYPHfL0RVVfntTMFMedAgJeeLSbsftg1tpTx1PXNe7AEzwRmdtAtD6UiQ4Jyo8T9bZOpx7ije0uybstmLVUU9C4msh8DLrN1iotKgbopxbkrXhcTxlVsU+1gO1eUVC3Y+nPs8G7PTX755mnSosapWsuv6Hl231rc0E8ZvT/WiOLNAdb0mVJYFRFC/RaZlOeEPdwvbuj19YkGbwKy8JhRriwMmivip2r+Cm8HJ2g/0PUNUtgenPuZSEODhq77qGlzkAbguRPc4M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2d5b29-7760-483e-56b7-08db5c68e84e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 15:09:44.6592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xVxnG8aCDm5XvCZ/HKx9dm+h05ZTe0heqw5/Bc9ExCqbDfZ7rh+zDX7IUMU0xRqN/GFm955WdsfKzp2cvp+2/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_10,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240124
X-Proofpoint-GUID: Ct40mKgXi6h4p1XbaPoVNbbZAmZ32YvZ
X-Proofpoint-ORIG-GUID: Ct40mKgXi6h4p1XbaPoVNbbZAmZ32YvZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 24, 2023, at 11:08 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2023-05-22 at 16:52 -0700, Dai Ngo wrote:
>> Remove the check for F_WRLCK in generic_add_lease to allow file_lock
>> to be used for write delegation.
>>=20
>> First consumer is NFSD.
>>=20
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/locks.c | 7 -------
>> 1 file changed, 7 deletions(-)
>>=20
>> diff --git a/fs/locks.c b/fs/locks.c
>> index df8b26a42524..08fb0b4fd4f8 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -1729,13 +1729,6 @@ generic_add_lease(struct file *filp, long arg, st=
ruct file_lock **flp, void **pr
>> if (is_deleg && !inode_trylock(inode))
>> return -EAGAIN;
>>=20
>> - if (is_deleg && arg =3D=3D F_WRLCK) {
>> - /* Write delegations are not currently supported: */
>> - inode_unlock(inode);
>> - WARN_ON_ONCE(1);
>> - return -EINVAL;
>> - }
>> -
>> percpu_down_read(&file_rwsem);
>> spin_lock(&ctx->flc_lock);
>> time_out_leases(inode, &dispose);
>=20
> I'd probably move this back to the first patch in the series.
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

I asked him to move it to the end. Is it safe to take out this
check before write delegation is actually implemented?


--
Chuck Lever


