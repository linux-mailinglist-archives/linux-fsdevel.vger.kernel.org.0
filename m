Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABE1535160
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 17:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243809AbiEZPZL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 11:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbiEZPZJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 11:25:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FBEBA9B9;
        Thu, 26 May 2022 08:25:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QEWAGW012392;
        Thu, 26 May 2022 15:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=M9Bh1UNh/SagD+M+GSBmOkZ1Pth6GVZCZVikBSjuHaQ=;
 b=A8AtvpLtvqOHS5Hm21M+6bpx3fZPzveG7c4XVH5a9de/L8fgjhTOGhCm7tEjNDTRN03Q
 iBTaJxc79+JFi//dQby8zTkrBS+pXhCl2SQmyJo7m9N7ZX+XIosz7RxpVO7/pswXFsVY
 SFw/2JY1qG4bCQn6RhvLKXVA/fev1+dJVksCMv+8KH7c/ypqxK7f/dDBg9GffbIXCQcz
 1ajfQ65PGgA6xw4hqIXH3PUSXc0v/o/Sv/lEjU4m9aNLnMvp9k+Qa+3PRPcULzI0pmcz
 cRu9CII78QlurcPm67yPVgAILShCb93HbkuYru9qjh2OfWhTl9fI5RFl5+b3M5PakQme aQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tbd0mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 May 2022 15:25:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24QFOLWu009196;
        Thu, 26 May 2022 15:25:02 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g93wxekfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 May 2022 15:25:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7NwJDsC1gyx5mJZKvWyfd2VAbAmmdBfsVKR4YBblNjaRG5cda+/nNB+xBNmFoA5AKmB/clkMKTuDJbXQuFbSGGxpXG6JPFU0+P6erSpjWDb6whWQ06rXLpZqAVh0kcuBLLlcckzXeP3m/OLLJ0dTx407+w3/jUdLrnHmlmZUCJIZDEueVHOhp5SMY1vz8bSoQzL0nHDJGjOF8+QxHeMkLFvCOZ4HfFd97ip1vYyHd0aC4tRvf0uv0/U4s4bX85fstLyYRf7iwyC6YHKiijaQ2JsblwfggsA7SnUhYNxpyObZkwlfUEJ1+bixft+4uOBEy1MaTKzVl5Cv53NeBd2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9Bh1UNh/SagD+M+GSBmOkZ1Pth6GVZCZVikBSjuHaQ=;
 b=GIHt4+l2DEMYq3u8+urZfSy15ITqi2GCqjem/EjI3HYAxOG+VlInvPP+8BF0fyu7Nqolilgr8er5UmYXUdvAd4p7jj05xFOv1JpRIUY9RvYWRXlbKIzbVCUd4VxwTsC7lmZurg2Vt5h1dawmoMlbDiPnY7FqJcqQ4uRHW9tZbkZbjOI62hxdMyCZC+uhiW8zdSbAfswVy/GAdZXL8TWTbWeqfe7w+x11F1KYzW/AUBOcfuUJI1ZQme0QUcm9WjBDFS001XjOBuFypAuNMcCbzpsG4KGxlq1mCEE60CS9ugwDxpZhMck8AVGS7dWpUv7OvO8NzbRD8IomLlrBgu5pmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9Bh1UNh/SagD+M+GSBmOkZ1Pth6GVZCZVikBSjuHaQ=;
 b=H2G5fEgXIzh+qiEROoVOt8UGRDG4EEdzd4MLCFsyv7YPdvfRU2cK2QWnEW1WBiB1yzDXjOxpC97JUQrhWIOmpCseUnwxyGUKrgufNyV3l7SWMYrO8Ep2u6KUr5sEB98/9Z3hkL1K3M38XyNtDwkT1M+sHQZ0R5KJ6CnRc2P3AU4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (13.101.138.120) by
 CH0PR10MB5083.namprd10.prod.outlook.com (13.101.45.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Thu, 26 May 2022 15:25:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 15:25:00 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] nfsd changes for 5.19
Thread-Topic: [GIT PULL] nfsd changes for 5.19
Thread-Index: AQHYcRTDuuIhgYj+oUimOhFpRCqrEQ==
Date:   Thu, 26 May 2022 15:25:00 +0000
Message-ID: <DDB7B172-52E3-4015-9BD2-9BCDE209E5AC@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d3d5cff-45f8-47ac-5184-08da3f2be656
x-ms-traffictypediagnostic: CH0PR10MB5083:EE_
x-microsoft-antispam-prvs: <CH0PR10MB5083C5130720DC72BEEB73E393D99@CH0PR10MB5083.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PBsWdJ2dtEfFbD8LxAecpzo1J9vwIv5kwNjOTY3n/nVKJNElB81kicsv+GFrgzRVvSDOBJfHwgEgBXzD2ltte/+0an+a0nUzYp7ypZsZefjBF3m2Is1pmOK/eagKoeh1XocBy0rui0OmeBmwUeS3q6mrSzsK4fRJC1ck5Iz8cvH9Z4UQ2I+wuSaK163s7rBd638MYfEzbW/M21LaPhs3jPrZcduS9Gw7FvaDC1oK2M0dnuxMVaoFwWLFOZ6wP40Mhcauf6lfJw7RdVAmLjU9zrmdd5EpDObuNaJfj6yy7kjprBp8EJzRtclKeKylQyBFSCMb1k4IFNqkcLz/75MvTPJY5CQnO2rvaRVWi0Q2+c+3P730wyoqy2GIxPK53qJr0DI8sP6p0m02/r8oE4emS9Fq2mFc6WmlyYPIMU2BsJKuLKOTo+Pt8GccECNi+9Uhe5AnRJ+B/b+gly7fUUOKHw3+hBNJv3xqi4gwwz/kjfck2VBWMS8T6x4ouZnZRbv5kyUYNZGGygN9m6dEkup13S333uWk/yLYYwBwD7/ukCq1FWvEWiw0FavyjBc64m2uC2ImYATAKHeZR8r6LTVYO6iDZOziBJB6QrS6XfSw5HtupUOQATyKiHhHPrWviGrKan/vGygHY6utRVC60Ni9uC5kb7Bhg+M70YlKR85SYIPs3yb4wrPpn2i6W6+/mmJnbww37/NUdozcCKmvpr1tEsLYCEdtpHfo7I4judCJ7ooRR+/jtQ1+vHuNqMLKvE2Ao91ozZfae+QDbYlPbeloDxLhl5umzap+MlgqFIgaO6PN/NeY3Td8BEav30uddKZ7LBM5pBNn6T2lfj67e/p63ffxFda6zmz6nNqqyj48/K8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(66476007)(66556008)(66946007)(64756008)(66446008)(8676002)(76116006)(4326008)(38070700005)(2616005)(122000001)(26005)(6512007)(71200400001)(91956017)(38100700002)(5660300002)(45080400002)(8936002)(2906002)(6506007)(83380400001)(86362001)(508600001)(6486002)(6916009)(54906003)(966005)(186003)(36756003)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?exZHRiWytMvH8+mOxCTQqvSsOmjxUWHPFFdfXgACiuAt3UJw3bxgyZH0zI0h?=
 =?us-ascii?Q?UWgv5lqfrNrPCokgmiIbnVyvZK5AuVFP9gTCazzX/EP0YrKak/jA6Di1LxsU?=
 =?us-ascii?Q?Ztm6bbaUv/79vouN8T2+N/7Jxlq1/DvGrcZLexaf0b3pfzKV9nv626RoyBLL?=
 =?us-ascii?Q?jVGkM8FmkRJsa5A12U4q/h0uY5osylh2JjvRIoAzjwiq/hGes5vmVcfKnALt?=
 =?us-ascii?Q?RNRGfR4bFvUDSCN4p3ZC1/+9kZvJ7chKeKLoyNzwrewnRuzI15YVM7CbdF+3?=
 =?us-ascii?Q?LKjNnWqjpE74DquVXCU5Dkm4yeC+4aOxObUQwyJtA99gEzqQsmWwhNrStEZ7?=
 =?us-ascii?Q?iszRtf+bodCqRaWJjS78NUdK1fzjlaokm2uQ305iHdPU2aDt5aE9JMqyCdfN?=
 =?us-ascii?Q?tgitGfl/ss5bZMeT23rXmeIkv+IGWRJ/Sgyun+UfsW5XTSeJHmmevRRafSfz?=
 =?us-ascii?Q?gpsJks0DD7LQrFCAe5YIOmYMDTxvEoawSr6cJVz6lG+f/+xZrEvWzXSzgOja?=
 =?us-ascii?Q?BoWHQRdRb9bp7ocg10xyXKhFlONnkecRo2nAiz7hxLcV5UEw12vWf1mNKLjo?=
 =?us-ascii?Q?s3et666OQfbX+LxTK6i8DLnQK8UWCUdtj92Z6UiEss1buImt2ZE/J/YCoL7i?=
 =?us-ascii?Q?WRVwnkiTNWckeU7C+RHsXG+VA6cbfE4ZfmzHPcA1RXgL9Mi9/GQP3s7shVbB?=
 =?us-ascii?Q?oCilfa/t8HmnoAEjKNvdESzS3GSnJO+H+ywZnKfTjZMz/QzMdDjn6CzKG60+?=
 =?us-ascii?Q?Z91VrucK60wSVplkmoMZtBxySLhhWEMUhpBLGy7zNIevfzVi/AFtpVBDPxUQ?=
 =?us-ascii?Q?+217E1uTvx8dl1Rk5BeMbrXC23o3lASiwJDxnXA7wdCAxkT3XSl01uXbXraA?=
 =?us-ascii?Q?l/HarTmEfMe3aedo02wKQd4aRp0mM5Q5uMD257Ilz9oN/JXnJFM0nU+gavvA?=
 =?us-ascii?Q?sl1YwVrpud8gf7yR9py8vL2kYgtbIvoNl48cRiTSZxeMFbxJrXw4g00Ci7Ip?=
 =?us-ascii?Q?G71GFFc2I514ncoEXpGKqwDQ2Vu8+IE3cal0OyakT8oXumONmXR0T3MQL5e+?=
 =?us-ascii?Q?LBy0dP2G892s5jBMb1MoId6sH7megL0U+O20wEHqroi/s39UwKfb8QZjTjai?=
 =?us-ascii?Q?MgVRwcJXkclSiYyK4+P1pO+gEigS1LDyWV6J3s2N5mXDgHWLDUmGlM7Oy3nY?=
 =?us-ascii?Q?6GO3GRQtcvfgs7kvqmBMqWXUF5EruRKA1PtqNzyiTVbtwfkW6k7eZviNlhPB?=
 =?us-ascii?Q?LxRuAA0DNFLLqk2S4YtyH3KTRZ4FXsIu72fX8oPPoT8ipwTobtVLBkI6cm2M?=
 =?us-ascii?Q?nOb8JA6L3PADYCO6aTEqo6OPKfJWTZmTEElaNueYrO07CnU2CSCqLJv2TOnp?=
 =?us-ascii?Q?Kq2hhslrMkBxGJBr7iaxN/ROfA14TrKlpE9OGy8NiRv3x6VgB2iGFkPSkmtt?=
 =?us-ascii?Q?rSB1+BEMNtVBVT75viYqhow7KyF9GJpixcoQaDBVQze23do+q1/4VqS9S40z?=
 =?us-ascii?Q?6aMmuzbTmG0Y+Ue8dlHYXjC4wl6h/ebAkOzIV+XI+q33tfkFKAdzkguOR7QQ?=
 =?us-ascii?Q?JU3Y9gAovniRZdW4YztD2nQfMk5TJq8JKfU8MA3InpUi/OWpT2mVi9doR9zf?=
 =?us-ascii?Q?2grZEdTH5DNJWq0T2GmjuSbxkmYE0Dx/NH7P5l8MoGBNaz3Ftq6gynvsBA/K?=
 =?us-ascii?Q?+8CfasJMvzjKXlTJw6Ncy2Tu4EhjQt0ovMO9AAju1kLQFFl2vDkkm54/ZJe9?=
 =?us-ascii?Q?GSjlCJvblWYC9mabGMALcq4eEJlGNuw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6CDEA4CBA97AE446845262BF633BF21C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3d5cff-45f8-47ac-5184-08da3f2be656
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2022 15:25:00.6281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ONPzA13ZkmZQ2EwA0OoZYgVmdmy2EVr9+z44YoHh/TSM/e1fainlyAAOwIqm4CNOp3ZDnpZEOeD8583Sdye3Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5083
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-26_06:2022-05-25,2022-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205260073
X-Proofpoint-GUID: L8Nzpwmt0BMy2OtUJYi_gHbve-sibU66
X-Proofpoint-ORIG-GUID: L8Nzpwmt0BMy2OtUJYi_gHbve-sibU66
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus-

As of this writing, there is one known unresolved NFSD-related
issue, documented in this thread:

https://lore.kernel.org/linux-nfs/AM9P191MB16655E3D5F3611D1B40457F08EF49@AM=
9P191MB1665.EURP191.PROD.OUTLOOK.COM/

It appears to be rare and has been around for a while. Diagnosis
is ongoing.

Review for "NFSD: Instantiate a struct file when creating a
regular NFSv4 file" was conducted over the past few weeks,
culminating in this thread:

https://lore.kernel.org/linux-nfs/165247056822.6691.9087206893184705325.stg=
it@bazille.1015granger.net/T/#m4e81166848350ca51b3d0015133c3cc4d23ada2c

A v2 of 8/8 with the requested changes was posted and no further
comments were made. The v2 version appears in this pull request.

Despite the Commit Date on the last few patches in this pull
request, those patches have been in linux-next for a couple of
days at least.

I'm not aware of any merge conflicts at this time.


--- cut here ---

The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c=
:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5=
.19

for you to fetch changes up to 08af54b3e5729bc1d56ad3190af811301bdc37a1:

  NFSD: nfsd_file_put() can sleep (2022-05-26 10:50:51 -0400)

----------------------------------------------------------------
NFSD 5.19 Release Notes

We introduce "courteous server" in this release. Previously NFSD
would purge open and lock state for an unresponsive client after
one lease period (typically 90 seconds). Now, after one lease
period, another client can open and lock those files and the
unresponsive client's lease is purged; otherwise if the unrespon-
sive client's open and lock state is uncontended, the server retains
that open and lock state for up to 24 hours, allowing the client's
workload to resume after a lengthy network partition.

A longstanding issue with NFSv4 file creation is also addressed.
Previously a file creation can fail internally, returning an error
to the client, but leave the newly created file in place as an
artifact. The file creation code path has been reorganized so that
internal failures and race conditions are less likely to result in
an unwanted file creation.

A fault injector has been added to help exercise paths that are run
during kernel metadata cache invalidation. These caches contain
information maintained by user space about exported filesystems.
Many of our test workloads do not trigger cache invalidation.

There is one patch that is needed to support PREEMPT_RT and a fix
for an ancient "sleep while spin-locked" splat that seems to have
become easier to hit since v5.18-rc3.

----------------------------------------------------------------
Chuck Lever (25):
      NFSD: Clean up nfsd_splice_actor()
      SUNRPC: Clean up svc_deferred_class trace events
      SUNRPC: Cache deferral injection
      SUNRPC: Make cache_req::thread_wait an unsigned long
      SUNRPC: Remove dead code in svc_tcp_release_rqst()
      SUNRPC: Remove svc_rqst::rq_xprt_hlen
      SUNRPC: Simplify synopsis of svc_pool_for_cpu()
      NFSD: Clean up nfsd3_proc_create()
      NFSD: Avoid calling fh_drop_write() twice in do_nfsd_create()
      NFSD: Refactor nfsd_create_setattr()
      NFSD: Refactor NFSv3 CREATE
      NFSD: Refactor NFSv4 OPEN(CREATE)
      NFSD: Remove do_nfsd_create()
      NFSD: Clean up nfsd_open_verified()
      NFSD: Instantiate a struct file when creating a regular NFSv4 file
      NFSD: Remove dprintk call sites from tail of nfsd4_open()
      NFSD: Fix whitespace
      NFSD: Move documenting comment for nfsd4_process_open2()
      NFSD: Trace filecache opens
      NFSD: Clean up the show_nf_flags() macro
      SUNRPC: Use RMW bitops in single-threaded hot paths
      NFSD: Fix possible sleep during nfsd4_release_lockowner()
      NFSD: Modernize nfsd4_release_lockowner()
      NFSD: Add documenting comment for nfsd4_release_lockowner()
      NFSD: nfsd_file_put() can sleep

Dai Ngo (7):
      NFSD: add courteous server support for thread with only delegation
      NFSD: add support for share reservation conflict to courteous server
      NFSD: move create/destroy of laundry_wq to init_nfsd and exit_nfsd
      fs/lock: add helper locks_owner_has_blockers to check for blockers
      fs/lock: add 2 callbacks to lock_manager_operations to resolve confli=
ct
      NFSD: add support for lock conflict to courteous server
      NFSD: Show state of courtesy client in client info

Julian Schroeder (1):
      nfsd: destroy percpu stats counters after reply cache shutdown

Sebastian Andrzej Siewior (1):
      SUNRPC: Don't disable preemption while calling svc_pool_for_cpu().

Zhang Xiaoxu (2):
      nfsd: Unregister the cld notifier when laundry_wq create failed
      nfsd: Fix null-ptr-deref in nfsd_fill_super()

 Documentation/filesystems/locking.rst    |   4 ++
 fs/locks.c                               |  61 ++++++++++++++++-
 fs/nfsd/filecache.c                      |  54 +++++++++++++--
 fs/nfsd/filecache.h                      |   2 +
 fs/nfsd/nfs3proc.c                       | 141 +++++++++++++++++++++++++++=
+++++------
 fs/nfsd/nfs4proc.c                       | 264 +++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++-------------
 fs/nfsd/nfs4state.c                      | 353 +++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++-------------------
 fs/nfsd/nfs4xdr.c                        |   2 +-
 fs/nfsd/nfscache.c                       |   2 +-
 fs/nfsd/nfsctl.c                         |  20 ++++--
 fs/nfsd/nfsd.h                           |   5 ++
 fs/nfsd/state.h                          |  31 +++++++++
 fs/nfsd/trace.h                          |  34 ++++++++--
 fs/nfsd/vfs.c                            | 255 +++++++++++++++------------=
-----------------------------------------
 fs/nfsd/vfs.h                            |  14 +---
 fs/nfsd/xdr4.h                           |   1 +
 fs/open.c                                |  42 ++++++++++++
 include/linux/fs.h                       |  12 ++++
 include/linux/sunrpc/cache.h             |   8 +--
 include/linux/sunrpc/svc.h               |   4 +-
 include/trace/events/sunrpc.h            |  12 ++--
 net/sunrpc/auth_gss/svcauth_gss.c        |   4 +-
 net/sunrpc/cache.c                       |  18 ++++-
 net/sunrpc/debugfs.c                     |   3 +
 net/sunrpc/fail.h                        |   2 +-
 net/sunrpc/svc.c                         |  24 ++++---
 net/sunrpc/svc_xprt.c                    |  17 ++---
 net/sunrpc/svcsock.c                     |  19 ++----
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |   1 -
 net/sunrpc/xprtrdma/svc_rdma_transport.c |   2 +-
 30 files changed, 985 insertions(+), 426 deletions(-)

--
Chuck Lever



