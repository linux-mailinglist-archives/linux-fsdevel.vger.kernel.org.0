Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6360D5272F5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 May 2022 18:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiENQeP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 May 2022 12:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbiENQeN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 May 2022 12:34:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C7A19284;
        Sat, 14 May 2022 09:34:11 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24EFNPBY012365;
        Sat, 14 May 2022 16:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kH9RIr6IqJ30eEsw3qoJmJD6TxBsP8gu+Cl2Iu1gl3I=;
 b=XJxfPVfDV64qMzxHgBcYjCMRbhqL3/lEEAvg8IcqxVHJVUUZ4LxX8i5jR6HVZ0y0dt6J
 wMOFcGr2myPsMUXl5B9ULGI9Dn6x/js1s8h8fuMK67kXyRagO9NLsucQKKga9thfOyap
 xaZWD4viAVlAmC6/ppbfWxfr/yVybgneGbZe9kaz6joqfoaN03NqJ4n01XhAYosnbgFq
 s6FiAhQf/y33X1FYUcRGoCfbTzJsSZ+0SrPrjg6iE8wWgy4lNvZaRt7DBHzkQqePNNx+
 M1sKF8E15K9nW0tJ/u9ach4q2fTmjCcnoQd4bujg9fR2R+SpMuKIZPXXevqEZ+R2IYzC IA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ytgjt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 May 2022 16:34:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24EGVuqS037835;
        Sat, 14 May 2022 16:34:10 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v0d723-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 May 2022 16:34:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5aQZiLqFWYyGD/P2FIuLYJ+yhxb7XyCYnDifJSltbd4XShGUH7wBqGqylwdD6qXTQCpEhKOLkUm1Q4QEA0ejQa9n2h8FY28YH1mHPMnXaeVAOYAfmvWqEvW079FdPjCztld5t2MZEk6S9xSnfZMPmo1COzhSXn9TOnXCTZmHs671ZMEU99j2IfDYuGuIEBAV8IgYdGlN4gZNEXRJV6pbX6TUyVDMHIWPdKfhxAlBw/xm+ggGwpAsl1Nqnf4xM+sLHfekKWaa0PQrYJXZQpqkhXRGlCrepU94btrQHHuahE8OnHZ/ygKc6Wng/ycX3t4KGYGlYpKYvEGynT7SXFIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kH9RIr6IqJ30eEsw3qoJmJD6TxBsP8gu+Cl2Iu1gl3I=;
 b=jDY34LGrCPrphh1hlEMrzgR/61ppelwlUrlY3iHDR1IFIs1fo3Lv20yma8x5iLIXPkDGmxxel20L8P1xjSRMaDVD+0UOYGyFae4AwUBSOzUu+KbRrDS0UZf5+Qh0kN8NxXNAvaSHDE9/rLYnqenBLYKM0lGiMT6FIpz3ViiVQTt6ZThuxjXtIJ0kdP4I64jvKy+XBdhFeBsNIpYru46ZYpupyQLaTojngaGVLWJpX/0oqGZUtZpM1BKkZYsL2mgjgOWvF6Ew9KlwWUZKROCJZNmCyfGLKsqR95HHG5G1dyAYSDCQRr1CiPd3IiLLhDYQIHIduD7SQqlW0bmeVgCcZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kH9RIr6IqJ30eEsw3qoJmJD6TxBsP8gu+Cl2Iu1gl3I=;
 b=fnYmFo9nCSGAPaDGbyq8+Re0QDmk2pwQuz6D7fLj0MtbZMNtS/mSfpt9sYngGPiHErBL41GbxUT7sS8T8JPdTTNBWIbCMJHsoDb2Y9SuUE0mYGSsx57WBEEggZXJkjR7nRJtgEfZeybfU7x1apLSX97v7GzJ70Lh0GGX3uRaYLY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6018.namprd10.prod.outlook.com (2603:10b6:208:3b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Sat, 14 May
 2022 16:34:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%7]) with mapi id 15.20.5250.018; Sat, 14 May 2022
 16:34:08 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 8/8] NFSD: Instantiate a struct file when creating a
 regular NFSv4 file
Thread-Topic: [PATCH 8/8] NFSD: Instantiate a struct file when creating a
 regular NFSv4 file
Thread-Index: AQHYZwFPyffJyYt1iEa92YmYIhOeH60dYT4AgABrTACAAMZPgA==
Date:   Sat, 14 May 2022 16:34:08 +0000
Message-ID: <F0D6DEC4-2589-4501-9A35-93C68CBE642F@oracle.com>
References: <165247056822.6691.9087206893184705325.stgit@bazille.1015granger.net>
 <165247081391.6691.14842389384935416109.stgit@bazille.1015granger.net>
 <Yn7ZooZbccSrAru0@zeniv-ca.linux.org.uk>
 <Yn8zpAbwe9yFq8/i@zeniv-ca.linux.org.uk>
In-Reply-To: <Yn8zpAbwe9yFq8/i@zeniv-ca.linux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba33e952-06a0-486a-8843-08da35c79188
x-ms-traffictypediagnostic: BL3PR10MB6018:EE_
x-microsoft-antispam-prvs: <BL3PR10MB6018DCA3E6815041A29EF5CC93CD9@BL3PR10MB6018.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kbgqkKDOOlU7lHaNtR9W4YvDZfva1lfB8QPSZfSZY8xDWHwCoHn05426ELIYO3KlJAWJk6hiMIohUl72pWWHr6iJknViJEaFHF/jGEWbNb2EMqe9GctVPnbjjjDatqscpIFaPyQbrW9Baa5W/rmVq2iO/00xPqMm3VlzTyo61hkvNefYrkJolebnXBI+89mIdvslu+tOMm1as1l9I/hsu0XraoEJsFalGDGKSsQAv9y6Cs6U1Ejy+NH8BWtg7CYuj+/HZV6dhfXZqTpRhVrtrQkFVZGjmOox3e5QP+NoRwVKfM0esBVYD+3M8OVNu9+tTy1YOSAaj0CzFas9GRj+g707y+PAkDHtsno+xF1DgSxIaI1uEQNvb943C7w6gB/6C0nS7NLwEM4UFvHx30LusqELvfdyMZe4uerQvMRyP5+qJ/F87Ouhs3SN0RH5q+JthlUfVH9t1dmTRAfziAnPgrNBs2JeFeUH1p3NI8rHOQ+cCY+ol0K+hzf6L4JUQisCwb+VwiEEsFu3tojTSnSFWM3WabcroppIzmMGKND3XpQWrHowXEhM+HSWjsm9ovn00TE2BYxLv7RB1n+ammZ2y1J0DurrBlxmV6t0lZ5x0ukPY+nDcWOttggv1ZW0QWwTZePubNuD5z7iyKsoIMkbLv8blwZtr7psA5Rt57nEkIsbT5NekwIgWqnpSOwUiH9gcpxwUf6VH0AX2qclA2WQ1p58aWUqQ0BMzjJR2pqybMV2k2p5F+fw8lAVrtgovedS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(8936002)(71200400001)(5660300002)(33656002)(83380400001)(38070700005)(508600001)(76116006)(38100700002)(26005)(86362001)(6512007)(2616005)(186003)(91956017)(122000001)(53546011)(2906002)(6506007)(4326008)(36756003)(66446008)(6916009)(66476007)(64756008)(316002)(66946007)(8676002)(66556008)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CYD1tmYsU71QKRHU3yMxD4qC7LiD5hWw0kRbx5RNTP0DeRKSPg+tszPcVuOp?=
 =?us-ascii?Q?ccodCueQIDabhvOiZxFeBLFVaztOFmVj57vUUyK4oeZY1OMuZS95gCIXjStP?=
 =?us-ascii?Q?AlioJvpYxBPXfmg3vnZTDwvmxayO4jMy9n9XgevpaW3p2FZxi4nqBqyng+yD?=
 =?us-ascii?Q?4kyMHP0ABzrZrPUJHBK6/UXESLP8tpJLT7YWJVEcEDSYs9j6JjBrJqMc++9+?=
 =?us-ascii?Q?+VotcXCIDvn7OaVFsSCcUuJP4tI10HESzDMVhjcCHBmJ71G9OregZiN0EDOy?=
 =?us-ascii?Q?4iis2/oDpWV/A+/wS4iE5D7RP6orRWFsOcNR6CqWYv/Nh0KKmEYDGNc4aU/H?=
 =?us-ascii?Q?pSEUa7VngmnTlQ9qouPwFP5dC3twFgimxoPER70agbNsiVXu+7/3GUtI747s?=
 =?us-ascii?Q?Ga/1CXd4e5gaPHWNBnqZ2QjLXMJ+cmCJUT6ZAwbL7Ur+96HuxofEjS9rOJtI?=
 =?us-ascii?Q?lrrNMcRyqh3Kb92paJV0BLyTwCFvFitORIRzw0ia7qTyh8DPIgVRFXG6urXE?=
 =?us-ascii?Q?cqTXkjsFbZQNa42t0AaAvKzxmIH55tZkszXyHXVtVU1sNkUXj8aJYuFxyPJ5?=
 =?us-ascii?Q?dqeLwAgOGWuprEBOqyjO7LsT38oBlnjrjBryQxMTCacJPNDsF97M8tT01+2g?=
 =?us-ascii?Q?OQtLM4vCQGOllbEg5sv33HziAJtW20f31qHd5LMZyZ9DiQQ1ViPKLkiTbfh/?=
 =?us-ascii?Q?T+wjC26O7hVmD60MJGmjMlyW2YJLbET+UwHRwKWH+JOX4M8zbor/EH6LEF/i?=
 =?us-ascii?Q?C7rIrIDAaA3Kf5NSC9z84xEz5OLqfkfkDLxb3Si//cfOjoa50j2TmLbd4iRu?=
 =?us-ascii?Q?VLz/EHuNpxK/XgDSu19LRwyrALIOOfFtt3I1RjzyFKw/btuJqG4wm0JN3dpp?=
 =?us-ascii?Q?az+1CW0TjQL2A+5NoIXBLBsjE7HpUrszK9udvX66ZJnYA5LUOKrG2co4evuS?=
 =?us-ascii?Q?487irhmc6V5B4zFE0hcKuNgufFdn5lbKMxKjivhs8bvsq+m27l2PUjHsxhNa?=
 =?us-ascii?Q?guwBXo53UGP1Ao6VL0FRnYIb6hNgSS7Rg4Tf8AzxsIRIznO39Y8fXDztrvG+?=
 =?us-ascii?Q?U3mcM9Xqfh8FlT9ljBNgDoCCYYR+qtss5jVosJSOBEDA/zKfGx1Sy44D9pnt?=
 =?us-ascii?Q?wANl9WiEM2rPj9NC0HwthTueJ87cJKM039hYncln6uzxC7EFuuDS1/5iqTqW?=
 =?us-ascii?Q?C7p7hn8HiYaqWHkOEA81BWX8aiIf/KbDhV/YlCTYRCl6KSzp5eU7/wGiDpup?=
 =?us-ascii?Q?v3OTlZzmTn3GTWimTZHMTTaVEB+0ukTMl7fRBXrHsUytj4+lj9XO24rBpeqg?=
 =?us-ascii?Q?JQ9QV273xAERSN1Fq1u+XuzRx/ANQch/9yfHHW3Wd6/sYE1EJgtdMNknMl/8?=
 =?us-ascii?Q?LtsEojVoL1i/uY1uE1hXsTd3imQMhNivtxMSYMCJM05TolAVBt23SW6s5ucT?=
 =?us-ascii?Q?0GP35sF51TN1JxvX8ngUGCTppTxTNlNYs0bI0zWzM2+hFaTcJK16Rkd38KAg?=
 =?us-ascii?Q?mOalBxyboINrjq4ks4ivPNR0kXlwpe56lDAUab5L7pCv+eceJ9QYA3+zJFcL?=
 =?us-ascii?Q?Y/AJ/7DKBif/8HsfGl1ifZ+GObPJqd74LolKs/C0WhOLVdLaLqLh0liGsZS3?=
 =?us-ascii?Q?xqw0x2DMMlobBnuWGL7VJ5drXh8H2mQLjTT5oQnFQwWKw25fkC84sQ2pp2Hn?=
 =?us-ascii?Q?FFp3SzIo+2zLz7tQ4QvdsaNxhVG3vOitj1wkKJBlCPiiiKg1Z4+jBQ3sAyzG?=
 =?us-ascii?Q?Mf3dPBUoDAuZnTXiOkh4+orBiDFAoaE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E6014F35C95AB54AB248E429CE1D80A0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba33e952-06a0-486a-8843-08da35c79188
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2022 16:34:08.2598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BROJvPDavebQ2Vm1mt4l2TLBcm6EvT63Y8a0tt00ALXDU/JtAYZot/gNLnYgilhe3YWjB1ql+oNE/fvpM/Eoxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6018
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-14_02:2022-05-13,2022-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205140088
X-Proofpoint-GUID: ciRHy3BPXQROoUPxwgpcm-p-XR8qFpgW
X-Proofpoint-ORIG-GUID: ciRHy3BPXQROoUPxwgpcm-p-XR8qFpgW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 14, 2022, at 12:44 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
> On Fri, May 13, 2022 at 10:20:18PM +0000, Al Viro wrote:
>=20
>> Yuck.  dget_parent() is not entirely without valid uses, but this isn't
>> one.  It's for the cases when parent is *not* stable and you need to gra=
b
>> what had been the parent at some point (even though it might not be the
>> parent anymore by the time dget_parent() returns).  Here you seriously
>> depend upon it remaining the parent of that sucker all the way through -
>> otherwise vfs_create() would break.  And you really, really depend upon
>> its survival - the caller is holding it locked, so they would better
>> have it pinned.
>=20
> As an aside, the reason why vfs_create() takes inode of parent directory
> and dentry of child is basically that it's easier to describe the locking
> rules that way: vfs_create(..., dir, child, ...) must be called with
> 1) dir being held by caller (exclusive) and
> 2) child->d_parent->d_inode =3D=3D dir, which is stabilized by (1)
>=20
> inode of parent directory is a redundant argument - it can be easily
> derived from the child dentry, for all that family.  The only real
> objection against dropping it from vfs_create() and friends is that
> having rules described as "inode of parent dentry of child must be held
> exclusive by the caller" invites breakage along the lines of
>=20
> 	parent =3D dget_parent(child);
> 	inode_lock(d_inode(parent));
> 	vfs_create(..., child, ...);	// WRONG
> 	inode_unlock(d_inode(parent));
> 	dput(parent);
>=20
> which *seems* to match the rules, but actually breaks them badly -
> 'parent' in the snippet above might be no longer related to child by the
> time dget_parent() returns it, so we end up calling vfs_create() with
> wrong directory locked, child->d_parent being completely unstable, etc.
> Note that the difference from your code (which is correct, if redundant) =
is
> rather subtle.

I'm not sure I have anything informed to say, but here are some
random thoughts:

vfs_create() has to work for both exclusive and non-exclusive
create requests, but its caller is responsible for those semantics.
So perhaps the current vfs_create() synopsis is correct (though as
you point out above, the locking requirements could be documented
a little better?).

NFSD also has the interesting problem of re-exporting NFS mounts.
We'd like the exclusiveness of the creation request to be passed
through to the originating NFS server properly (maybe via
->atomic_open?). Perhaps that's for another day.

But locking the parent means that file creation is serialized,
which for large directories or workloads like "tar", impacts
throughput. Again, perhaps that's for another day.


> If you have any suggestions how to describe these locking rules without
> an explicit inode-of-parent argument, I would really like to hear those.
> The best I'd been able to come up with had been "there's an inode
> locked exclusive by the caller that had been observed to be equal to
> child->d_parent->d_inode at some point after it had been locked", which
> is both cumbersome and confusing...

I have a v2 of my patch which hopefully addresses your comments
(many thanks for those). I'm not sure I captured the gist of your
documentation request though. Looking at some other callers of
vfs_create() such as do_mknodat(), dentry_create's use of the
@path argument might be, well, unexpected. If it looks insane to
you, it can be adjusted.

I'll post v2 shortly and we can iterate on that.


--
Chuck Lever



