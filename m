Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6621161831B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 16:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiKCPna (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 11:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiKCPnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:43:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204231B1C8;
        Thu,  3 Nov 2022 08:43:16 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3FXZFl011682;
        Thu, 3 Nov 2022 15:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=kMlE3y1d7GI290lg12m93JGZ9IegnoZ+8HWwqGzSwUw=;
 b=lLI5mXXvHn0pdozqC8ev7nt4Tq/bmMn21NVWotJVU1wZu5UZr9+zG4FiDe8OwvOBEpSD
 GD/7Hdp4KbXFW2CCIGLVAh5XOpIoCGecHCx/J8BqL3E/TA6ppaTBBo7nWF0XCq9vRLap
 hTUJ64x931wFpJ6xm6rh2FW4qZfFVSXRUcwtVuSvq8hfIsJ5DnKZYV0ZuY5dmgrjo6vO
 UIKI1U5XREAUGSmDN8gjDlh+g+2ayd4kp3XWpkHaBLgzgagwtEwAwmzD65ma9fdRWwDY
 klgGYDZwfYEX/43hyWLI03wWcKlGDGO4rcaoEXXoexIZZNanT/khkw2/369a5SsZpnr4 dQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgty359e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 15:42:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3EsEG7035641;
        Thu, 3 Nov 2022 15:42:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmcug11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 15:42:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBWWRPlnE0F9HXODCvHK3wrM6exoqOewbUNUTAa2LRxF9jyM1qiPESLjh4gTUHS9lik5dVwNT7b9yFyPO1/8UJ+5sCHaGN5Z29zQ3pGg4maqFbwACVmN0nEQvmgyNQcSInSWvR59nXsVAACJmL5bGNr9ly6l6hkDhW8+lqTcmpOqG0Lvp88oB4YM2K1nHBabDGGyGO9xbsmJtUbLnReHP0j0qi4x4Jc9vGNPCcP336AT9mTpqoxW0LobCTf1ZCiGJDgefQ/1SP2SfFbXN2kag12YWjHynLmNyEocFhQTsJKUWjdfjcNnh6fxR6kEVh6yMyhF4DacFfcjCxUCsj6ArQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMlE3y1d7GI290lg12m93JGZ9IegnoZ+8HWwqGzSwUw=;
 b=KE4F/djOyEhKtdPvOtV/L0LzXziW+sUnnh4lX5DaJraFu1qUHBOjvEHzGwO2TuSdDpy2Y4L41mhxwy/DBiSMxFey9GuyYP1IurfCdGdP7mkptFI+HiAAGyVzPoUG6DSHAqbr649HkQr+1iVflfSAkZEV3qvsmPdtGVsB7ZJkkeORyhf1YiqueSeAbojL2gU3b3HrECDjRea0tO04M8RLFDUg97O7K01wwedb6hA1+ijv6NscUsmWqOv7xc0f2mbuscqKfdLQIKbTGHElYvSKrLN7aC7P0XnRVUAKTkZF2+SeeASUKE7PYN+P+WL5NVSrA4E5wElYLAnaKDTDyftfEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMlE3y1d7GI290lg12m93JGZ9IegnoZ+8HWwqGzSwUw=;
 b=fxPW3vaCNb9A1kBoothX+rHHxiQMfxOJ1YLWhTKdr30qH1m9kAS9sryv2HgVGhIgJ7kBAtgDarJSZzGYr9AIHghd1lx/5ujblv7AUZlcYn1CwyJL0z9hhy7v4md6MGtLhr4/dQ4HoMrHlzp9npTSupwsEqTUlquZNfBrGALp3Mk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4402.namprd10.prod.outlook.com (2603:10b6:303:95::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 15:42:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 15:42:56 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Theodore Ts'o <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        Neil Brown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "jack@suse.cz" <jack@suse.cz>, Bruce Fields <bfields@fieldses.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v7 7/9] nfsd: use the getattr operation to fetch i_version
Thread-Topic: [PATCH v7 7/9] nfsd: use the getattr operation to fetch
 i_version
Thread-Index: AQHY4hdEjzJEXJmuz06vp2aYITmsLa4tcbKA
Date:   Thu, 3 Nov 2022 15:42:56 +0000
Message-ID: <8E06CE2C-E8FB-4727-9ABF-C1EA6AAC067E@oracle.com>
References: <20221017105709.10830-1-jlayton@kernel.org>
 <20221017105709.10830-8-jlayton@kernel.org>
In-Reply-To: <20221017105709.10830-8-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4402:EE_
x-ms-office365-filtering-correlation-id: 9c42ff0c-58c8-494b-6e7e-08dabdb213d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AYisBUCxb4fA3Dq9ELCnZlIMVyFVulvct4Rj1OddttscCW58p+qiYObaryLsYixtXvar7A28YgKr/eFVc3CTrSJt2GVbcfNibMlW8QP+NEW8pRf+CS9H2Yz292RDx8QCF8IaSe0roKBbXQqC0d3PRD/W2bj+ywY/SuJniqOjYMjsQ3DmZyCrJAQPPS8PDr77QVy5rQHsRBl7AY2pCjb8acyZtD3VifuFIQbLVdLCeYZb4f9HRjs/7OM+N/O+LgIUSEBFD7r9/mFgxioRakybRrknmDNkc07bjn6Rh9hhdArBf4cR/BGFlVKvOG+fqEH6CAWSiAPKGa2uNVWTdGDSporojwCMpzJtEc/BstgAE5tFvKZEB5hJCKb9AQClYD+bEVVnI2LksDA4g9CteS0nJuexGvm7vxLPhGu8hs5h99UTd9b10p507Wo/X8qD6joLThEyVVFm9akGUb55+L9/5gs0OoSBSuvL7dkeZTy+AUQoaVBv/88eWgrdU9B35mXfJORTM4MbLinCWS4nvhYFD6cXZo99Z4ShWX0dF02Q/Vxro4ivmy+ya6vl4NDpCql16+tAAiQmPq2xhQjboGEln+C3UshesThOS9m7REumTzc+jdzfGan/g6JXXNBE+ouS7Jtf5ua9ZP7PaDqHVhrGO/DQ2967embOWKCi6PemsyY6Tm1Eua3iN/ba4SY+8sDlgRMBUKm0/xA6M9LfvDwfWUe39LaGYLqHm+nzKXCzLUmP258XVkN04CyPejouFL98HiYyW1mnkOYn5DVJosPnJRL764Cj+dIyq9Oc+u77zG5WejPXzy/iPwsDJ6kIvuAZ7QMR5czVsySfUUL3v84UMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199015)(83380400001)(66899015)(86362001)(71200400001)(2906002)(6506007)(6486002)(38100700002)(38070700005)(4326008)(33656002)(36756003)(53546011)(6512007)(26005)(186003)(478600001)(2616005)(64756008)(66556008)(316002)(66476007)(66946007)(8676002)(66446008)(91956017)(5660300002)(8936002)(54906003)(76116006)(6916009)(41300700001)(122000001)(7416002)(60764002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A9IaI+b+B79yvrfMktONQfhDvbRUwUkYkSCJUlkKdJ8Gzahai2tJjF9M4zi0?=
 =?us-ascii?Q?0qXmNL0cnylM3CjlFCPkwzc5HbIWCHrvVP4KhhSFtydwBiQ3/TQSu/4Euf+v?=
 =?us-ascii?Q?400BQPyknnJhRj7ojV4HWTw3GXkxzl4YsNDztc7fibVNAhQqMs6Q91YDEYI8?=
 =?us-ascii?Q?MC6dAmFHQquxu/hd2YFa8B+MaPXGFFwFGF76g5H5O1hfoJXCivRnkA/lQuPf?=
 =?us-ascii?Q?5tt2hhcTJSb8JTXQfJb78Zhlz7vRKLPWMVr5uJDDHa+ljoXHDP8WCp4Hah92?=
 =?us-ascii?Q?kkkLubMRuQuMZn3tPKs0xxEpBuwCpR28k/EM/sBeLtz8F188z/OO6oBob3nq?=
 =?us-ascii?Q?ijQlw485naT8J7mKYMGysZausplv986wTqcQ1E5WO9+YNAVvSFIiwBY1AOpS?=
 =?us-ascii?Q?53FX7zNj/vwKfrPyPGGnw0MFWDx+peNsVcpe0NeBhvYB4Mv79mB5vt80lWqx?=
 =?us-ascii?Q?wNm3pqg6o5aMLggzWkPLpa5ao2fZSHBJCTOiQH8XG1K+XQtTuKLNHn2xWSuk?=
 =?us-ascii?Q?TH3uyOoj3hg8W61S/YWyfcrUbsvkG8MAqGHdZWs+xpozcdXXGQb63r+++kT/?=
 =?us-ascii?Q?m9gSg0aZi7kJfERm2Xgpu1d3QSQXOkU0/I4gqhHrmKHJdF5y9iR3yjINVGL9?=
 =?us-ascii?Q?Bo3nArU0mJthWoqOlhTkpJ22K21R2Np2EyQc3tkcqmTqUG7Q/s3R2l0FblpR?=
 =?us-ascii?Q?OBEeV2azOFt2MfTqUGzCn47s+RQ+tcA0fLfWbEbb+NQZGUOO1M5ggUUYb8bz?=
 =?us-ascii?Q?U41LkJZ52DXvHe+wCeYbxKMgho1dwA7L947QZNvxvk10QLjFbGv3jyfNUEbf?=
 =?us-ascii?Q?69eoM2tRLWMutIUkvOXzXGJzzqncr66hSiSXDiML56E2LhApmKo6UpDhYhKa?=
 =?us-ascii?Q?llfvIw9pxbbSk8d0ZZGbyjgapZg3U7YMpv1Vb+1RwWTxjbaRXGOwmqKOdFQ0?=
 =?us-ascii?Q?QKoIAoVzqH3r1aQBL2GUPf/8I2gHeZu4DAi/IRkQEqf9usSLsDGiIdNtqJPA?=
 =?us-ascii?Q?da7PW9tTjtT4oOsI8+fNZZTaOc+eMIcp+IVRwH7rUdF5kYrtFM9yZepd2SVA?=
 =?us-ascii?Q?cFDP0m+zNW9dRy+whyM0FVSVDmqyIa/Du3kFvMhoCv7DGTui083sk7VJp3rq?=
 =?us-ascii?Q?MsOyE6Zxfyd2ES+kzBRLIcz74k0giYOPiZLhl/5Odf6F35TeyBMeS0FlBQ3l?=
 =?us-ascii?Q?dwEuK2xsUrP0lRiNG5FbWdX1Lsme0r3P63B1ZAG/y9XV4ULX0WD5ekN/hOT7?=
 =?us-ascii?Q?qeWEnNZsFt3NsJ87xsxNgJ/Fh6qdMUxoovtqIff+vcMfd18d9M1WiqmDbdlW?=
 =?us-ascii?Q?WCcYmR6WkF/LRWwS/zQJJn73ImTFvZYbhQuOezH92x0zHOLTNH/cfkBKE4wc?=
 =?us-ascii?Q?a7JWj/1sPGlWPLYc4DpRWecN1w6fqlPelU2oD6vYG5fQlV01HlIuXRDPU6s5?=
 =?us-ascii?Q?wpdGbMogfRsIp+Yp7PMhQw6yxYovAOC88PEr91SIYGPnU5Awpj7KT2ggoHFj?=
 =?us-ascii?Q?7BGnmLKK4dUo35ND2yFxnuuHWltztS2REIu3GYhzO1soIde3ayopPHveaNyy?=
 =?us-ascii?Q?aEsTDL5nr4fP0ccxK106sDB04F+1PvVOgWm5/5rOYh/aLGunf3MjV9VIbO6n?=
 =?us-ascii?Q?Gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <04E6149FF1F8954182B5129EB40715D0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c42ff0c-58c8-494b-6e7e-08dabdb213d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 15:42:56.0289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0za2EW69uoF6SMHvAeywHWvP6carnRxnd4nUKVV4BsVI3ZSdUBRTvj/LFCR0l/LLtAXJmiFmL0gsEWGcCgqD9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4402
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030104
X-Proofpoint-ORIG-GUID: _ss5efehKWa17UUB4hWxGa_tsyItVz0i
X-Proofpoint-GUID: _ss5efehKWa17UUB4hWxGa_tsyItVz0i
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Oct 17, 2022, at 6:57 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> Now that we can call into vfs_getattr to get the i_version field, use
> that facility to fetch it instead of doing it in nfsd4_change_attribute.
>=20
> Neil also pointed out recently that IS_I_VERSION directory operations
> are always logged, and so we only need to mitigate the rollback problem
> on regular files. Also, we don't need to factor in the ctime when
> reexporting NFS or Ceph.
>=20
> Set the STATX_VERSION (and BTIME) bits in the request when we're dealing
> with a v4 request. Then, instead of looking at IS_I_VERSION when
> generating the change attr, look at the result mask and only use it if
> STATX_VERSION is set.
>=20
> Change nfsd4_change_attribute to only factor in the ctime if it's a regul=
ar
> file and the fs doesn't advertise STATX_ATTR_VERSION_MONOTONIC.
>=20
> Reviewed-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> fs/nfsd/nfs4xdr.c |  4 +++-
> fs/nfsd/nfsfh.c   | 53 +++++++++++++++++++++++++++++++----------------
> fs/nfsd/vfs.h     |  7 ++++++-
> 3 files changed, 44 insertions(+), 20 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index bcfeb1a922c0..c19b6b00b620 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2906,7 +2906,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct s=
vc_fh *fhp,
> 			goto out;
> 	}
>=20
> -	err =3D vfs_getattr(&path, &stat, STATX_BASIC_STATS, AT_STATX_SYNC_AS_S=
TAT);
> +	err =3D vfs_getattr(&path, &stat,
> +			  STATX_BASIC_STATS | STATX_BTIME | STATX_VERSION,
> +			  AT_STATX_SYNC_AS_STAT);
> 	if (err)
> 		goto out_nfserr;
> 	if (!(stat.result_mask & STATX_BTIME))
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 7030d9209903..21b64ac97a06 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -628,6 +628,10 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
> 		stat.mtime =3D inode->i_mtime;
> 		stat.ctime =3D inode->i_ctime;
> 		stat.size  =3D inode->i_size;
> +		if (v4 && IS_I_VERSION(inode)) {
> +			stat.version =3D inode_query_iversion(inode);
> +			stat.result_mask |=3D STATX_VERSION;
> +		}
> 	}
> 	if (v4)
> 		fhp->fh_pre_change =3D nfsd4_change_attribute(&stat, inode);
> @@ -659,6 +663,10 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
> 	if (err) {
> 		fhp->fh_post_saved =3D false;
> 		fhp->fh_post_attr.ctime =3D inode->i_ctime;
> +		if (v4 && IS_I_VERSION(inode)) {
> +			fhp->fh_post_attr.version =3D inode_query_iversion(inode);
> +			fhp->fh_post_attr.result_mask |=3D STATX_VERSION;
> +		}
> 	} else
> 		fhp->fh_post_saved =3D true;
> 	if (v4)
> @@ -750,28 +758,37 @@ enum fsid_source fsid_source(const struct svc_fh *f=
hp)
> }
>=20
> /*
> - * We could use i_version alone as the change attribute.  However,
> - * i_version can go backwards after a reboot.  On its own that doesn't
> - * necessarily cause a problem, but if i_version goes backwards and then
> - * is incremented again it could reuse a value that was previously used
> - * before boot, and a client who queried the two values might
> - * incorrectly assume nothing changed.
> + * We could use i_version alone as the change attribute.  However, i_ver=
sion
> + * can go backwards on a regular file after an unclean shutdown.  On its=
 own
> + * that doesn't necessarily cause a problem, but if i_version goes backw=
ards
> + * and then is incremented again it could reuse a value that was previou=
sly
> + * used before boot, and a client who queried the two values might incor=
rectly
> + * assume nothing changed.
> + *
> + * By using both ctime and the i_version counter we guarantee that as lo=
ng as
> + * time doesn't go backwards we never reuse an old value. If the filesys=
tem
> + * advertises STATX_ATTR_VERSION_MONOTONIC, then this mitigation is not =
needed.
>  *
> - * By using both ctime and the i_version counter we guarantee that as
> - * long as time doesn't go backwards we never reuse an old value.
> + * We only need to do this for regular files as well. For directories, w=
e
> + * assume that the new change attr is always logged to stable storage in=
 some
> + * fashion before the results can be seen.
>  */
> u64 nfsd4_change_attribute(struct kstat *stat, struct inode *inode)
> {
> +	u64 chattr;
> +
> 	if (inode->i_sb->s_export_op->fetch_iversion)
> 		return inode->i_sb->s_export_op->fetch_iversion(inode);
> -	else if (IS_I_VERSION(inode)) {
> -		u64 chattr;
> -
> -		chattr =3D  stat->ctime.tv_sec;
> -		chattr <<=3D 30;
> -		chattr +=3D stat->ctime.tv_nsec;
> -		chattr +=3D inode_query_iversion(inode);
> -		return chattr;
> -	} else
> -		return time_to_chattr(&stat->ctime);
> +	if (stat->result_mask & STATX_VERSION) {
> +		chattr =3D stat->version;
> +
> +		if (S_ISREG(inode->i_mode) &&
> +		    !(stat->attributes & STATX_ATTR_VERSION_MONOTONIC)) {
> +			chattr +=3D (u64)stat->ctime.tv_sec << 30;
> +			chattr +=3D stat->ctime.tv_nsec;
> +		}
> +	} else {
> +		chattr =3D time_to_chattr(&stat->ctime);
> +	}
> +	return chattr;
> }
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 120521bc7b24..c98e13ec37b2 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -168,9 +168,14 @@ static inline void fh_drop_write(struct svc_fh *fh)
>=20
> static inline __be32 fh_getattr(const struct svc_fh *fh, struct kstat *st=
at)
> {
> +	u32 request_mask =3D STATX_BASIC_STATS;
> 	struct path p =3D {.mnt =3D fh->fh_export->ex_path.mnt,
> 			 .dentry =3D fh->fh_dentry};
> -	return nfserrno(vfs_getattr(&p, stat, STATX_BASIC_STATS,
> +
> +	if (fh->fh_maxsize =3D=3D NFS4_FHSIZE)
> +		request_mask |=3D (STATX_BTIME | STATX_VERSION);
> +
> +	return nfserrno(vfs_getattr(&p, stat, request_mask,
> 				    AT_STATX_SYNC_AS_STAT));
> }
>=20
> --=20
> 2.37.3
>=20

--
Chuck Lever



