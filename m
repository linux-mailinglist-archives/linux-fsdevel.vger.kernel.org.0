Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B048A4AB31C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 02:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344367AbiBGB0L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 20:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiBGB0K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 20:26:10 -0500
X-Greylist: delayed 7692 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 17:26:05 PST
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9217DC06173B;
        Sun,  6 Feb 2022 17:26:05 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 216Hq7B3003611;
        Sun, 6 Feb 2022 23:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Vu3k5J14vY5tR5XumdEa/0lRsFRuG74+zF9h9TANV5A=;
 b=gkUqmxojD6IRzBK7sMa3J7eQqPGBFfrlZp0ct0YkBeoS+JqqnG+iPURcIKqi+DVxti1P
 rvHMlKZmNzVidc5CoGC6L3+M56otVA8HG+ZKK7Qy9G3o/Yxfg3HkDRZetI9S44kmXjzT
 vF9SGFwhYPin/rPMpQ5CGPyuHJUWq6XdsOjfOATcA6ftzaHy/Yl4bsayv6U7QllKWbiv
 TeLo3jpjVzGT1xOfMy9hw3ncx44Qz8qHq+muo964lamRiwkyToC9g8Yi3o0buK3L8Gpd
 NlLnhGoaQ46qLwWxPxbYYdtbAV2efJN17Mb22C8hzEtOg9Q2cxnS5VQ3ESRp9tWeD6JY 2A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1g13m91f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 23:17:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 216NFe3B180992;
        Sun, 6 Feb 2022 23:17:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3020.oracle.com with ESMTP id 3e1jpmhfmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 23:17:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrOTY4NYqmST2d0smmWIeaPwVejL5b0va5eh3oCbj3zsZzeSYbdlIxOiuhVHPhFGiY8xM9g5apgM8AptzlwBsLf7TWzUHzNFEuweLqbH6IgF0QjgMdtmezKEs+PYc8/vVfJ92ht/GztUE+O3buzFDVK2HpJNV9bQ3giVuobUJKi+dFwBMGpTHndNtEGCo0gt0l+j7NwqE60tmdeiUXTRNiIjDaFwzqN6AaJey4egQfYKsgiAGL03t9S9AJu4AAhK7751sWc56ifmuAj986E1fpwjm8sSljekzQTKh26yyqdsjdS/C3ytWprLPTFwr8oV3h+kVoB6zMxYYLj4bgbmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vu3k5J14vY5tR5XumdEa/0lRsFRuG74+zF9h9TANV5A=;
 b=TqNIPfOJFK+RNA+8INrOayh8IoJ/fTT7jJrldPMYBxz99wy2ipdk07PuZcMHTXVrOQeGUZRJNjIu3+xy7Gog3pR512eQ5Wm2jLcpBb20v4ebRIdi5FnwwyNw18QAG0ZCvpxUMJuxaqAthwQ8Qqc67AlXHzSnrMLXcNWPmgENkQbyBN1eCiupjpi4G2THolsOnthdZskf7WL9xfjWYafIZMc8P5vbu7gsSHNT0zlNQABSyLKO94ILjz3HixQv7KzaOgMZyeazT5GVAH1EV5UJoHds+NYoxmHcPBjX+Pdscw9myCkWrYzDi5NIHE5OhbKTXXyB6JADuma5dvmdNBl29w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vu3k5J14vY5tR5XumdEa/0lRsFRuG74+zF9h9TANV5A=;
 b=xISPLwPGV+VP7lEuItj3/+RpaSD0IdmIhYmlMMmMb9Tzu+Furx3zU8uWCIZOHaQfZngo/qJm7/r+XL2L6ZEbrp1QanHUfXqtPYF6E7vB0aAeUXfO1/9kbEraPKNfdpY3xYmjzNgJoxYvuQbSrJRLh765u7tbLLtVqnPJLHUXpUg=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by BY5PR10MB3764.namprd10.prod.outlook.com (2603:10b6:a03:1f9::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Sun, 6 Feb
 2022 23:17:46 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.018; Sun, 6 Feb 2022
 23:17:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v11 3/3] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v11 3/3] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHYG6Dj6wpeypQdekCSVDVzqn0rf6yHKDsA
Date:   Sun, 6 Feb 2022 23:17:45 +0000
Message-ID: <84EDDBE7-4217-4D1C-8F48-0B8706764047@oracle.com>
References: <1644183077-2663-1-git-send-email-dai.ngo@oracle.com>
 <1644183077-2663-4-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1644183077-2663-4-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c95350d2-2c03-4fec-7772-08d9e9c6e207
x-ms-traffictypediagnostic: BY5PR10MB3764:EE_
x-microsoft-antispam-prvs: <BY5PR10MB376415C97C0D574643EC899D932B9@BY5PR10MB3764.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xHsyhsMVSFTbZ6pg5W/G9wGJB/s3D7zz6X2tjtGC+5vy3IW7lDA+WadgjYW9zrMA25lc5syDY93xM1qN0IDOTYsedggZY7aNMMVv03JL+ormG1rQcS+G+dFU3kn6tFDT94M2sA/tkhlXelaoFKFwuZTpVY8k+D3Q/4v1ZOypgBz25ecSCZcrReiEDVmBTNfKqW0hyUs1SCES99NrKLDFSdyWufLMOXhnEiiTrIWnUiNTtzA4/LkxdVYJ3eFgQAMQiBqdmu+r2AFvcrMPIoUbCXIZaKSS1TP5XIhCzZeMtqU9fc3OGb8HMKo40qrom7CS/CEZs6uHRRYcOayql3ERoBn8Lx0qOpvplpiXEsOQrnxyIWubKKuuIRGpO4a5vzk5McpugW0CBiMv5pWUTH1YPwsUgDs3Qz9UWjg3p3fnumUyILhSQWXNoYp/xxPFZULWQUq8FnJRPHN2nGtigxfbHifdyEpD6SfjhMJwij0/DQWN7cMg3uzcePjenVkWM5xdfvZYVrwsOgppUF3QuPbesx6thRklS5UnpF8qZyFJIY/syim1rpuuONv/rTxYAwS+h3Lmp/BXLeVzNx6z4caZKjDG7qbNQICLwNcF4j7aIOVUx++3cs//s9HKHNi6EL0N1bvjbs8+hYtBFtB+trjkDyjuV90XaB1RM/2CIJ+is4junhsiD2BgRA9CNMy4o88H/6eRsqRR8II4GLO9hSlFOKpG+h7Ur3maIGwVmooLDuqBRMstsTzAO6G9auHzXv/6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(38100700002)(6486002)(33656002)(53546011)(122000001)(38070700005)(186003)(5660300002)(30864003)(71200400001)(26005)(6512007)(2616005)(8936002)(36756003)(8676002)(4326008)(6862004)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(6506007)(316002)(6636002)(83380400001)(2906002)(37006003)(54906003)(86362001)(45980500001)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mR7o94Cm1ywXveYBF4+qtpOeK0KPiUWWt+NtYxyBJcdXPwW1vHPFzlz5qaW4?=
 =?us-ascii?Q?fehLlJ6MCVDqsjt7F19Hju8DrJyRxZsi+tG3wS4aG9krP8dLwa4mK3vhb6Qj?=
 =?us-ascii?Q?ggtEzWFr8GFIuMmaUZvSHW5uiUZfrn/s2vqqYYSIwZxxTdKFwFMMZ0QWB3aC?=
 =?us-ascii?Q?Yaz8gzZZYY01QPRhmoAWXj2mg+T+clVBrx9T9rwjk1q4RSsIiwzoUEgvcapX?=
 =?us-ascii?Q?ONk4JzoLnqVXObLL3cWFlzvX2ultq5pWlyw9L2sFVJR64CRbU7l3L/ip+vgS?=
 =?us-ascii?Q?XMybNoQ7wzCa48WaE4ovSanKvw2VXirWUsRbTMN3m6lWXN222vwRBjsQVdSb?=
 =?us-ascii?Q?zdtgBTbnblTlTk7s0aXnuXmguvtguzs0Ux+eFF9kPYaUB+svsyyC8Ix4gmfq?=
 =?us-ascii?Q?owRKz7qPEEbv3L/aDWbM1U1DNnuKu/dVc9BS7YiMtCcNvJADeamDHj+b8ja2?=
 =?us-ascii?Q?SfJ7uK5H8JhYU2tfR5FZ0yW2TQVpm3wQ4XgachIHRUXmkCI3ChNuJZS80/FM?=
 =?us-ascii?Q?6FaMC8/1lHaVZ3wb1gh/s49ijTwwotaY09i6YIK/FJtltFYu8rcab0h1epCs?=
 =?us-ascii?Q?n0R7Vv/Gv5MUS7A+2bRIRpXyCr7Hb5pKHgszPWXoWdN4fFRVZ2wnf+LQ1f8d?=
 =?us-ascii?Q?1qAAWFS2rpuhU28EfDCwD+8nWH/jNo7GVvg12EF7PB56x4f8D3h9pR5Dnh7r?=
 =?us-ascii?Q?d2QTadq2Au8W/l3s3hiExwadDf3oTSJ1D4q3OS3QFGDtdh/nB4k47Z3Ah+pt?=
 =?us-ascii?Q?M5MD4ZrQd2SU3hu0PsHRGcpd89rlgOmo3GRByuIfl7XfzdcgIPuRAFO5O6WC?=
 =?us-ascii?Q?BedBMB18tje/2l7samL/AmZ2D5pnuB1E+qnrb5VnYZlMxkXo7AWAuksT0saL?=
 =?us-ascii?Q?j2/g2wvf6pj4ohwzKuL5TgrcphhtGtLmX3/eGhaurKIpg/GmXwSYLSxrzAfz?=
 =?us-ascii?Q?3vSYUUHSDw7BH5DqB5HR1pw/OaXVXkFnvfVIHfdVkqiH+6jHGOgY7/QyWiJf?=
 =?us-ascii?Q?46ZcTn75b9oT0Viil2o8+8fJNxeujM4Q+GD3YT408qC1JaMlH+OHWaJIbsRf?=
 =?us-ascii?Q?I8T3eg8TQlmYV+BLNXqEJ/IrBSwOXTm6DSCqF4vqqFC2ll5limp+NPOA07G1?=
 =?us-ascii?Q?asSWMc+2KZs519yz9oxdulxIhvGddqyKSIRNqK38Rn/tlv9TIn7ge4CN518x?=
 =?us-ascii?Q?mY0SDOwAc9HyJ1btrubf9MR8IpM858UW8VNHw7ZvdEZ1gpizuweDVK6jUo26?=
 =?us-ascii?Q?NMzjSa6GaO36MLmq/+Yz5je5e73yboCc1DpW1yMjTMhu8go/SqKN+73G8RAA?=
 =?us-ascii?Q?kavCeYl2PHhwUfCWJU/K1TCrcKiugr1vT+0aX1iWrH2GjwZA7efQgkj3J1eU?=
 =?us-ascii?Q?0I+GCru8Cu1oluBU+XAlTOW2i1RA0sQ/8bYx4QNH5dxJV7fOB48gkufQm6jC?=
 =?us-ascii?Q?noPjCXf98xDBQzaTCnNp7TNvTuvUKIBHUoOCyc3QODfHhA4O94vXSDYI4KOy?=
 =?us-ascii?Q?BraVVMa5csdoLUycu1F0q/K7i+h4rSrGnydcgOCerr+t7Bc68NAAu/SHcsSS?=
 =?us-ascii?Q?dsOKlZFXSAADYFyfL9KuvQblQAguvr9V8Efb1qH87LwynrsryOm2kJaJGcEw?=
 =?us-ascii?Q?hyyvrPbix02gydIYmLDLFqo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F717DA0D82EFAA4A8B911DDE94269018@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95350d2-2c03-4fec-7772-08d9e9c6e207
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2022 23:17:45.3478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R691ODdbyB4+2DNZwsMI8ilHwO1YGYQvuVEqda87CZwRVrNtZbbIVYXQbnGjQQulGXEHgiOvB1vr7kHOAok6lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3764
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10250 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202060168
X-Proofpoint-GUID: X1CU67H5_Z-4ciOKEOV413KmVg1GX4zN
X-Proofpoint-ORIG-GUID: X1CU67H5_Z-4ciOKEOV413KmVg1GX4zN
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Feb 6, 2022, at 4:31 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Currently an NFSv4 client must maintain its lease by using the at least
> one of the state tokens or if nothing else, by issuing a RENEW (4.0), or
> a singleton SEQUENCE (4.1) at least once during each lease period. If the
> client fails to renew the lease, for any reason, the Linux server expunge=
s
> the state tokens immediately upon detection of the "failure to renew the
> lease" condition and begins returning NFS4ERR_EXPIRED if the client shoul=
d
> reconnect and attempt to use the (now) expired state.
>=20
> The default lease period for the Linux server is 90 seconds.  The typical
> client cuts that in half and will issue a lease renewing operation every
> 45 seconds. The 90 second lease period is very short considering the
> potential for moderately long term network partitions.  A network partiti=
on
> refers to any loss of network connectivity between the NFS client and the
> NFS server, regardless of its root cause.  This includes NIC failures, NI=
C
> driver bugs, network misconfigurations & administrative errors, routers &
> switches crashing and/or having software updates applied, even down to
> cables being physically pulled.  In most cases, these network failures ar=
e
> transient, although the duration is unknown.
>=20
> A server which does not immediately expunge the state on lease expiration
> is known as a Courteous Server.  A Courteous Server continues to recogniz=
e
> previously generated state tokens as valid until conflict arises between
> the expired state and the requests from another client, or the server
> reboots.
>=20
> The initial implementation of the Courteous Server will do the following:
>=20
> . When the laundromat thread detects an expired client and if that client
> still has established state on the Linux server and there is no waiters
> for the client's locks then deletes the client persistent record and mark=
s
> the client as NFSD4_CLIENT_COURTESY and skips destroying the client and
> all of its state, otherwise destroys the client as usual.
>=20
> . Client persistent record is added to the client database when the
> courtesy client reconnects and transits to normal client.
>=20
> . Lock/delegation/share reversation conflict with courtesy client is
> resolved by marking the courtesy client as NFSD4_CLIENT_DESTROY_COURTESY,
> effectively disable it, then allow the current request to proceed
> immediately.
>=20
> . Courtesy client marked as NFSD4_CLIENT_DESTROY_COURTESY is not allowed =
to
> reconnect to reuse itsstate. It is expired by the laundromat asynchronous=
ly
> in the background.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

Dai, thanks for the quick turn-around.

More comments below:


> ---
> fs/nfsd/nfs4state.c | 459 +++++++++++++++++++++++++++++++++++++++++++++++=
-----
> fs/nfsd/nfsd.h      |   1 +
> fs/nfsd/state.h     |   6 +
> 3 files changed, 425 insertions(+), 41 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 1956d377d1a6..5a025c905d35 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1917,10 +1917,27 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *=
sessionid, struct net *net,
> {
> 	struct nfsd4_session *session;
> 	__be32 status =3D nfserr_badsession;
> +	struct nfs4_client *clp;
>=20
> 	session =3D __find_in_sessionid_hashtbl(sessionid, net);
> 	if (!session)
> 		goto out;
> +	clp =3D session->se_client;
> +	if (clp) {
> +		clp->cl_cs_client =3D false;
> +		/* need to sync with thread resolving lock/deleg conflict */
> +		spin_lock(&clp->cl_cs_lock);
> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags)) {
> +			spin_unlock(&clp->cl_cs_lock);
> +			session =3D NULL;
> +			goto out;
> +		}
> +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
> +			clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
> +			clp->cl_cs_client =3D true;
> +		}
> +		spin_unlock(&clp->cl_cs_lock);
> +	}
> 	status =3D nfsd4_get_session_locked(session);
> 	if (status)
> 		session =3D NULL;
> @@ -1990,6 +2007,7 @@ static struct nfs4_client *alloc_client(struct xdr_=
netobj name)
> 	INIT_LIST_HEAD(&clp->cl_openowners);
> 	INIT_LIST_HEAD(&clp->cl_delegations);
> 	INIT_LIST_HEAD(&clp->cl_lru);
> +	INIT_LIST_HEAD(&clp->cl_cs_list);
> 	INIT_LIST_HEAD(&clp->cl_revoked);
> #ifdef CONFIG_NFSD_PNFS
> 	INIT_LIST_HEAD(&clp->cl_lo_states);
> @@ -1997,6 +2015,7 @@ static struct nfs4_client *alloc_client(struct xdr_=
netobj name)
> 	INIT_LIST_HEAD(&clp->async_copies);
> 	spin_lock_init(&clp->async_lock);
> 	spin_lock_init(&clp->cl_lock);
> +	spin_lock_init(&clp->cl_cs_lock);
> 	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
> 	return clp;
> err_no_hashtbl:
> @@ -2394,6 +2413,10 @@ static int client_info_show(struct seq_file *m, vo=
id *v)
> 		seq_puts(m, "status: confirmed\n");
> 	else
> 		seq_puts(m, "status: unconfirmed\n");
> +	seq_printf(m, "courtesy client: %s\n",
> +		test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) ? "yes" : "no");
> +	seq_printf(m, "seconds from last renew: %lld\n",
> +		ktime_get_boottime_seconds() - clp->cl_time);
> 	seq_printf(m, "name: ");
> 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
> 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
> @@ -2801,12 +2824,15 @@ add_clp_to_name_tree(struct nfs4_client *new_clp,=
 struct rb_root *root)
> }
>=20
> static struct nfs4_client *
> -find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
> +find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root,
> +				bool *courtesy_client)

You gotta revert all of these. The boolean output parameter
is not needed in any of these "find" functions.

Sorry I didn't make that clear.


> {
> 	int cmp;
> 	struct rb_node *node =3D root->rb_node;
> 	struct nfs4_client *clp;
>=20
> +	if (courtesy_client)
> +		*courtesy_client =3D false;
> 	while (node) {
> 		clp =3D rb_entry(node, struct nfs4_client, cl_namenode);
> 		cmp =3D compare_blob(&clp->cl_name, name);
> @@ -2814,8 +2840,29 @@ find_clp_in_name_tree(struct xdr_netobj *name, str=
uct rb_root *root)
> 			node =3D node->rb_left;
> 		else if (cmp < 0)
> 			node =3D node->rb_right;
> -		else
> +		else {
> +			/* sync with thread resolving lock/deleg conflict */
> +			spin_lock(&clp->cl_cs_lock);
> +			if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY,
> +					&clp->cl_flags)) {
> +				spin_unlock(&clp->cl_cs_lock);
> +				return NULL;
> +			}
> +			if (test_bit(NFSD4_CLIENT_COURTESY,
> +					&clp->cl_flags)) {
> +				if (!courtesy_client) {
> +					set_bit(NFSD4_CLIENT_DESTROY_COURTESY,
> +							&clp->cl_flags);
> +					spin_unlock(&clp->cl_cs_lock);
> +					return NULL;
> +				}
> +				clear_bit(NFSD4_CLIENT_COURTESY,
> +					&clp->cl_flags);
> +				*courtesy_client =3D true;
> +			}
> +			spin_unlock(&clp->cl_cs_lock);
> 			return clp;
> +		}
> 	}
> 	return NULL;
> }
> @@ -2852,15 +2899,38 @@ move_to_confirmed(struct nfs4_client *clp)
> }
>=20
> static struct nfs4_client *
> -find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool se=
ssions)
> +find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool se=
ssions,
> +			bool *courtesy_clnt)

Ditto.


> {
> 	struct nfs4_client *clp;
> 	unsigned int idhashval =3D clientid_hashval(clid->cl_id);
>=20
> +	if (courtesy_clnt)
> +		*courtesy_clnt =3D false;
> 	list_for_each_entry(clp, &tbl[idhashval], cl_idhash) {
> 		if (same_clid(&clp->cl_clientid, clid)) {
> 			if ((bool)clp->cl_minorversion !=3D sessions)
> 				return NULL;
> +
> +			/* need to sync with thread resolving lock/deleg conflict */
> +			spin_lock(&clp->cl_cs_lock);
> +			if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY,
> +					&clp->cl_flags)) {
> +				spin_unlock(&clp->cl_cs_lock);
> +				continue;
> +			}
> +			if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
> +				if (!courtesy_clnt) {
> +					set_bit(NFSD4_CLIENT_DESTROY_COURTESY,
> +							&clp->cl_flags);
> +					spin_unlock(&clp->cl_cs_lock);
> +					continue;
> +				}
> +				clear_bit(NFSD4_CLIENT_COURTESY,
> +							&clp->cl_flags);
> +				*courtesy_clnt =3D true;
> +			}
> +			spin_unlock(&clp->cl_cs_lock);
> 			renew_client_locked(clp);
> 			return clp;
> 		}
> @@ -2869,12 +2939,13 @@ find_client_in_id_table(struct list_head *tbl, cl=
ientid_t *clid, bool sessions)
> }
>=20
> static struct nfs4_client *
> -find_confirmed_client(clientid_t *clid, bool sessions, struct nfsd_net *=
nn)
> +find_confirmed_client(clientid_t *clid, bool sessions, struct nfsd_net *=
nn,
> +		bool *courtesy_clnt)

Ditto.


> {
> 	struct list_head *tbl =3D nn->conf_id_hashtbl;
>=20
> 	lockdep_assert_held(&nn->client_lock);
> -	return find_client_in_id_table(tbl, clid, sessions);
> +	return find_client_in_id_table(tbl, clid, sessions, courtesy_clnt);
> }
>=20
> static struct nfs4_client *
> @@ -2883,7 +2954,7 @@ find_unconfirmed_client(clientid_t *clid, bool sess=
ions, struct nfsd_net *nn)
> 	struct list_head *tbl =3D nn->unconf_id_hashtbl;
>=20
> 	lockdep_assert_held(&nn->client_lock);
> -	return find_client_in_id_table(tbl, clid, sessions);
> +	return find_client_in_id_table(tbl, clid, sessions, NULL);
> }
>=20
> static bool clp_used_exchangeid(struct nfs4_client *clp)
> @@ -2892,17 +2963,18 @@ static bool clp_used_exchangeid(struct nfs4_clien=
t *clp)
> }=20
>=20
> static struct nfs4_client *
> -find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *=
nn)
> +find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *=
nn,
> +			bool *courtesy_clnt)

Ditto.


> {
> 	lockdep_assert_held(&nn->client_lock);
> -	return find_clp_in_name_tree(name, &nn->conf_name_tree);
> +	return find_clp_in_name_tree(name, &nn->conf_name_tree, courtesy_clnt);
> }
>=20
> static struct nfs4_client *
> find_unconfirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net =
*nn)
> {
> 	lockdep_assert_held(&nn->client_lock);
> -	return find_clp_in_name_tree(name, &nn->unconf_name_tree);
> +	return find_clp_in_name_tree(name, &nn->unconf_name_tree, NULL);
> }
>=20
> static void
> @@ -3176,7 +3248,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nf=
sd4_compound_state *cstate,
>=20
> 	/* Cases below refer to rfc 5661 section 18.35.4: */
> 	spin_lock(&nn->client_lock);
> -	conf =3D find_confirmed_client_by_name(&exid->clname, nn);
> +	conf =3D find_confirmed_client_by_name(&exid->clname, nn, NULL);
> 	if (conf) {
> 		bool creds_match =3D same_creds(&conf->cl_cred, &rqstp->rq_cred);
> 		bool verfs_match =3D same_verf(&verf, &conf->cl_verifier);
> @@ -3443,7 +3515,7 @@ nfsd4_create_session(struct svc_rqst *rqstp,
>=20
> 	spin_lock(&nn->client_lock);
> 	unconf =3D find_unconfirmed_client(&cr_ses->clientid, true, nn);
> -	conf =3D find_confirmed_client(&cr_ses->clientid, true, nn);
> +	conf =3D find_confirmed_client(&cr_ses->clientid, true, nn, NULL);
> 	WARN_ON_ONCE(conf && unconf);
>=20
> 	if (conf) {
> @@ -3474,7 +3546,7 @@ nfsd4_create_session(struct svc_rqst *rqstp,
> 			status =3D nfserr_seq_misordered;
> 			goto out_free_conn;
> 		}
> -		old =3D find_confirmed_client_by_name(&unconf->cl_name, nn);
> +		old =3D find_confirmed_client_by_name(&unconf->cl_name, nn, NULL);
> 		if (old) {
> 			status =3D mark_client_expired_locked(old);
> 			if (status) {
> @@ -3613,6 +3685,7 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *=
rqstp,
> 	struct nfsd4_session *session;
> 	struct net *net =3D SVC_NET(rqstp);
> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	struct nfs4_client *clp;
>=20
> 	if (!nfsd4_last_compound_op(rqstp))
> 		return nfserr_not_only_op;
> @@ -3645,6 +3718,16 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst =
*rqstp,
> 	nfsd4_init_conn(rqstp, conn, session);
> 	status =3D nfs_ok;
> out:
> +	clp =3D session->se_client;
> +	if (clp->cl_cs_client) {
> +		if (status =3D=3D nfs_ok)
> +			nfsd4_client_record_create(clp);
> +		else {
> +			spin_lock(&clp->cl_cs_lock);
> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
> +			spin_unlock(&clp->cl_cs_lock);
> +		}
> +	}
> 	nfsd4_put_session(session);
> out_no_session:
> 	return status;
> @@ -3667,6 +3750,7 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nf=
sd4_compound_state *cstate,
> 	int ref_held_by_me =3D 0;
> 	struct net *net =3D SVC_NET(r);
> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	struct nfs4_client *clp;
>=20
> 	status =3D nfserr_not_only_op;
> 	if (nfsd4_compound_in_session(cstate, sessionid)) {
> @@ -3679,6 +3763,12 @@ nfsd4_destroy_session(struct svc_rqst *r, struct n=
fsd4_compound_state *cstate,
> 	ses =3D find_in_sessionid_hashtbl(sessionid, net, &status);
> 	if (!ses)
> 		goto out_client_lock;
> +	clp =3D ses->se_client;
> +	if (clp->cl_cs_client) {
> +		status =3D nfserr_badsession;
> +		goto out_put_session;
> +	}
> +
> 	status =3D nfserr_wrong_cred;
> 	if (!nfsd4_mach_creds_match(ses->se_client, r))
> 		goto out_put_session;
> @@ -3783,7 +3873,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
> 	struct nfsd4_compoundres *resp =3D rqstp->rq_resp;
> 	struct xdr_stream *xdr =3D resp->xdr;
> 	struct nfsd4_session *session;
> -	struct nfs4_client *clp;
> +	struct nfs4_client *clp =3D NULL;
> 	struct nfsd4_slot *slot;
> 	struct nfsd4_conn *conn;
> 	__be32 status;
> @@ -3893,6 +3983,15 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
> 	if (conn)
> 		free_conn(conn);
> 	spin_unlock(&nn->client_lock);
> +	if (clp && clp->cl_cs_client) {
> +		if (status =3D=3D nfs_ok)
> +			nfsd4_client_record_create(clp);
> +		else {
> +			spin_lock(&clp->cl_cs_lock);
> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
> +			spin_unlock(&clp->cl_cs_lock);
> +		}
> +	}
> 	return status;
> out_put_session:
> 	nfsd4_put_session_locked(session);
> @@ -3928,7 +4027,7 @@ nfsd4_destroy_clientid(struct svc_rqst *rqstp,
>=20
> 	spin_lock(&nn->client_lock);
> 	unconf =3D find_unconfirmed_client(&dc->clientid, true, nn);
> -	conf =3D find_confirmed_client(&dc->clientid, true, nn);
> +	conf =3D find_confirmed_client(&dc->clientid, true, nn, NULL);
> 	WARN_ON_ONCE(conf && unconf);
>=20
> 	if (conf) {
> @@ -4012,12 +4111,18 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
> 	struct nfs4_client	*unconf =3D NULL;
> 	__be32 			status;
> 	struct nfsd_net		*nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
> +	bool courtesy_clnt =3D false;
> +	struct nfs4_client *cclient =3D NULL;
>=20
> 	new =3D create_client(clname, rqstp, &clverifier);
> 	if (new =3D=3D NULL)
> 		return nfserr_jukebox;
> 	spin_lock(&nn->client_lock);
> -	conf =3D find_confirmed_client_by_name(&clname, nn);
> +	conf =3D find_confirmed_client_by_name(&clname, nn, &courtesy_clnt);
> +	if (conf && courtesy_clnt) {
> +		cclient =3D conf;
> +		conf =3D NULL;
> +	}
> 	if (conf && client_has_state(conf)) {
> 		status =3D nfserr_clid_inuse;
> 		if (clp_used_exchangeid(conf))
> @@ -4048,7 +4153,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
> 	new =3D NULL;
> 	status =3D nfs_ok;
> out:
> +	if (cclient)
> +		unhash_client_locked(cclient);
> 	spin_unlock(&nn->client_lock);
> +	if (cclient)
> +		expire_client(cclient);
> 	if (new)
> 		free_client(new);
> 	if (unconf) {
> @@ -4076,8 +4185,9 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
> 		return nfserr_stale_clientid;
>=20
> 	spin_lock(&nn->client_lock);
> -	conf =3D find_confirmed_client(clid, false, nn);
> +	conf =3D find_confirmed_client(clid, false, nn, NULL);
> 	unconf =3D find_unconfirmed_client(clid, false, nn);
> +
> 	/*
> 	 * We try hard to give out unique clientid's, so if we get an
> 	 * attempt to confirm the same clientid with a different cred,
> @@ -4107,7 +4217,7 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
> 		unhash_client_locked(old);
> 		nfsd4_change_callback(conf, &unconf->cl_cb_conn);
> 	} else {
> -		old =3D find_confirmed_client_by_name(&unconf->cl_name, nn);
> +		old =3D find_confirmed_client_by_name(&unconf->cl_name, nn, NULL);
> 		if (old) {
> 			status =3D nfserr_clid_inuse;
> 			if (client_has_state(old)
> @@ -4691,18 +4801,41 @@ nfsd_break_deleg_cb(struct file_lock *fl)
> 	return ret;
> }
>=20
> +/*
> + * Function returns true if lease conflict was resolved
> + * else returns false.
> + */
> static bool nfsd_breaker_owns_lease(struct file_lock *fl)
> {
> 	struct nfs4_delegation *dl =3D fl->fl_owner;
> 	struct svc_rqst *rqst;
> 	struct nfs4_client *clp;
>=20
> +	clp =3D dl->dl_stid.sc_client;
> +
> +	/*
> +	 * need to sync with courtesy client trying to reconnect using
> +	 * the cl_cs_lock, nn->client_lock can not be used since this
> +	 * function is called with the fl_lck held.
> +	 */
> +	spin_lock(&clp->cl_cs_lock);
> +	if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags)) {
> +		spin_unlock(&clp->cl_cs_lock);
> +		return true;
> +	}
> +	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
> +		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
> +		spin_unlock(&clp->cl_cs_lock);
> +		return true;
> +	}
> +	spin_unlock(&clp->cl_cs_lock);
> +
> 	if (!i_am_nfsd())
> -		return NULL;
> +		return false;
> 	rqst =3D kthread_data(current);
> 	/* Note rq_prog =3D=3D NFS_ACL_PROGRAM is also possible: */
> 	if (rqst->rq_prog !=3D NFS_PROGRAM || rqst->rq_vers < 4)
> -		return NULL;
> +		return false;
> 	clp =3D *(rqst->rq_lease_breaker);
> 	return dl->dl_stid.sc_client =3D=3D clp;
> }
> @@ -4735,12 +4868,12 @@ static __be32 nfsd4_check_seqid(struct nfsd4_comp=
ound_state *cstate, struct nfs4
> }
>=20
> static struct nfs4_client *lookup_clientid(clientid_t *clid, bool session=
s,
> -						struct nfsd_net *nn)
> +			struct nfsd_net *nn, bool *courtesy_clnt)

Ditto.


> {
> 	struct nfs4_client *found;
>=20
> 	spin_lock(&nn->client_lock);
> -	found =3D find_confirmed_client(clid, sessions, nn);
> +	found =3D find_confirmed_client(clid, sessions, nn, courtesy_clnt);
> 	if (found)
> 		atomic_inc(&found->cl_rpc_users);
> 	spin_unlock(&nn->client_lock);
> @@ -4751,6 +4884,8 @@ static __be32 set_client(clientid_t *clid,
> 		struct nfsd4_compound_state *cstate,
> 		struct nfsd_net *nn)
> {
> +	bool courtesy_clnt;
> +
> 	if (cstate->clp) {
> 		if (!same_clid(&cstate->clp->cl_clientid, clid))
> 			return nfserr_stale_clientid;
> @@ -4762,9 +4897,12 @@ static __be32 set_client(clientid_t *clid,
> 	 * We're in the 4.0 case (otherwise the SEQUENCE op would have
> 	 * set cstate->clp), so session =3D false:
> 	 */
> -	cstate->clp =3D lookup_clientid(clid, false, nn);
> +	cstate->clp =3D lookup_clientid(clid, false, nn, &courtesy_clnt);
> 	if (!cstate->clp)
> 		return nfserr_expired;
> +
> +	if (courtesy_clnt)
> +		nfsd4_client_record_create(cstate->clp);
> 	return nfs_ok;
> }
>=20
> @@ -4917,9 +5055,89 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_=
fh *fh,
> 	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
> }
>=20
> -static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file=
 *fp,
> +static bool
> +nfs4_check_access_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
> +			bool share_access)
> +{
> +	if (share_access) {
> +		if (!stp->st_deny_bmap)
> +			return false;
> +
> +		if ((stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_BOTH)) ||
> +			(access & NFS4_SHARE_ACCESS_READ &&
> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_READ)) ||
> +			(access & NFS4_SHARE_ACCESS_WRITE &&
> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_WRITE))) {
> +			return true;
> +		}
> +		return false;
> +	}
> +	if ((access & NFS4_SHARE_DENY_BOTH) ||
> +		(access & NFS4_SHARE_DENY_READ &&
> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_READ)) ||
> +		(access & NFS4_SHARE_DENY_WRITE &&
> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_WRITE))) {
> +		return true;
> +	}
> +	return false;
> +}
> +
> +/*
> + * This function is called to check whether nfserr_share_denied should
> + * be returning to client.
> + *
> + * access:  is op_share_access if share_access is true.
> + *	    Check if access mode, op_share_access, would conflict with
> + *	    the current deny mode of the file 'fp'.
> + * access:  is op_share_deny if share_access is false.
> + *	    Check if the deny mode, op_share_deny, would conflict with
> + *	    current access of the file 'fp'.
> + * stp:     skip checking this entry.
> + * new_stp: normal open, not open upgrade.
> + *
> + * Function returns:
> + *	true   - access/deny mode conflict with normal client.
> + *	false  - no conflict or conflict with courtesy client(s) is resolved.
> + */
> +static bool
> +nfs4_conflict_clients(struct nfs4_file *fp, bool new_stp,
> +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
> +{
> +	struct nfs4_ol_stateid *st;
> +	struct nfs4_client *cl;
> +	bool conflict =3D false;
> +
> +	lockdep_assert_held(&fp->fi_lock);
> +	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
> +		if (st->st_openstp || (st =3D=3D stp && new_stp) ||
> +			(!nfs4_check_access_deny_bmap(st,
> +					access, share_access)))
> +			continue;
> +
> +		/* need to sync with courtesy client trying to reconnect */
> +		cl =3D st->st_stid.sc_client;
> +		spin_lock(&cl->cl_cs_lock);
> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &cl->cl_flags)) {
> +			spin_unlock(&cl->cl_cs_lock);
> +			continue;
> +		}
> +		if (test_bit(NFSD4_CLIENT_COURTESY, &cl->cl_flags)) {
> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &cl->cl_flags);
> +			spin_unlock(&cl->cl_cs_lock);
> +			continue;
> +		}
> +		/* conflict not caused by courtesy client */
> +		spin_unlock(&cl->cl_cs_lock);
> +		conflict =3D true;
> +		break;
> +	}
> +	return conflict;
> +}
> +
> +static __be32
> +nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
> 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
> -		struct nfsd4_open *open)
> +		struct nfsd4_open *open, bool new_stp)
> {
> 	struct nfsd_file *nf =3D NULL;
> 	__be32 status;
> @@ -4935,15 +5153,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *=
rqstp, struct nfs4_file *fp,
> 	 */
> 	status =3D nfs4_file_check_deny(fp, open->op_share_deny);
> 	if (status !=3D nfs_ok) {
> -		spin_unlock(&fp->fi_lock);
> -		goto out;
> +		if (status !=3D nfserr_share_denied) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
> +		if (nfs4_conflict_clients(fp, new_stp, stp,
> +				open->op_share_deny, false)) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
> 	}
>=20
> 	/* set access to the file */
> 	status =3D nfs4_file_get_access(fp, open->op_share_access);
> 	if (status !=3D nfs_ok) {
> -		spin_unlock(&fp->fi_lock);
> -		goto out;
> +		if (status !=3D nfserr_share_denied) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
> +		if (nfs4_conflict_clients(fp, new_stp, stp,
> +				open->op_share_access, true)) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
> 	}
>=20
> 	/* Set access bits in stateid */
> @@ -4994,7 +5226,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nf=
s4_file *fp, struct svc_fh *c
> 	unsigned char old_deny_bmap =3D stp->st_deny_bmap;
>=20
> 	if (!test_access(open->op_share_access, stp))
> -		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
> +		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
>=20
> 	/* test and set deny mode */
> 	spin_lock(&fp->fi_lock);
> @@ -5343,7 +5575,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct =
svc_fh *current_fh, struct nf
> 			goto out;
> 		}
> 	} else {
> -		status =3D nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
> +		status =3D nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
> 		if (status) {
> 			stp->st_stid.sc_type =3D NFS4_CLOSED_STID;
> 			release_open_stateid(stp);
> @@ -5577,6 +5809,122 @@ static void nfsd4_ssc_expire_umount(struct nfsd_n=
et *nn)
> }
> #endif
>=20
> +static bool
> +nfs4_anylock_blocker(struct nfs4_client *clp)
> +{
> +	int i;
> +	struct nfs4_stateowner *so, *tmp;
> +	struct nfs4_lockowner *lo;
> +	struct nfs4_ol_stateid *stp;
> +	struct nfs4_file *nf;
> +	struct inode *ino;
> +	struct file_lock_context *ctx;
> +	struct file_lock *fl;
> +
> +	spin_lock(&clp->cl_lock);
> +	for (i =3D 0; i < OWNER_HASH_SIZE; i++) {
> +		/* scan each lock owner */
> +		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
> +				so_strhash) {
> +			if (so->so_is_open_owner)
> +				continue;
> +
> +			/* scan lock states of this lock owner */
> +			lo =3D lockowner(so);
> +			list_for_each_entry(stp, &lo->lo_owner.so_stateids,
> +					st_perstateowner) {
> +				nf =3D stp->st_stid.sc_file;
> +				ino =3D nf->fi_inode;
> +				ctx =3D ino->i_flctx;
> +				if (!ctx)
> +					continue;
> +				/* check each lock belongs to this lock state */
> +				list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> +					if (fl->fl_owner !=3D lo)
> +						continue;
> +					if (!list_empty(&fl->fl_blocked_requests)) {
> +						spin_unlock(&clp->cl_lock);
> +						return true;
> +					}
> +				}
> +			}
> +		}
> +	}
> +	spin_unlock(&clp->cl_lock);
> +	return false;
> +}
> +
> +static void
> +nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist=
,
> +				struct laundry_time *lt)
> +{
> +	struct list_head *pos, *next;
> +	struct nfs4_client *clp;
> +	bool cour;
> +	struct list_head cslist;
> +
> +	INIT_LIST_HEAD(reaplist);
> +	INIT_LIST_HEAD(&cslist);
> +	spin_lock(&nn->client_lock);
> +	list_for_each_safe(pos, next, &nn->client_lru) {
> +		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> +		if (!state_expired(lt, clp->cl_time))
> +			break;
> +
> +		/* client expired */
> +		if (!client_has_state(clp)) {
> +			if (mark_client_expired_locked(clp))
> +				continue;
> +			list_add(&clp->cl_lru, reaplist);
> +			continue;
> +		}
> +
> +		/* expired client has state */
> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags))
> +			goto exp_client;
> +
> +		cour =3D test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
> +		if (cour &&
> +			ktime_get_boottime_seconds() >=3D clp->courtesy_client_expiry)
> +			goto exp_client;
> +
> +		if (nfs4_anylock_blocker(clp)) {
> +			/* expired client has state and has blocker. */
> +exp_client:
> +			if (mark_client_expired_locked(clp))
> +				continue;
> +			list_add(&clp->cl_lru, reaplist);
> +			continue;
> +		}
> +		/*
> +		 * Client expired and has state and has no blockers.
> +		 * If there is race condition with blockers, next time
> +		 * the laundromat runs it will catch it and expires
> +		 * the client. Client is expected to retry on lock or
> +		 * lease conflict.
> +		 */
> +		if (!cour) {
> +			set_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
> +			clp->courtesy_client_expiry =3D ktime_get_boottime_seconds() +
> +					NFSD_COURTESY_CLIENT_EXPIRY;
> +			list_add(&clp->cl_cs_list, &cslist);
> +		}
> +	}
> +	spin_unlock(&nn->client_lock);
> +
> +	list_for_each_entry(clp, &cslist, cl_cs_list) {
> +		spin_lock(&clp->cl_cs_lock);
> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags) ||
> +			!test_bit(NFSD4_CLIENT_COURTESY,
> +					&clp->cl_flags)) {
> +			spin_unlock(&clp->cl_cs_lock);
> +			continue;
> +		}
> +		spin_unlock(&clp->cl_cs_lock);
> +		nfsd4_client_record_remove(clp);
> +	}
> +}
> +
> static time64_t
> nfs4_laundromat(struct nfsd_net *nn)
> {
> @@ -5610,16 +5958,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	}
> 	spin_unlock(&nn->s2s_cp_lock);
>=20
> -	spin_lock(&nn->client_lock);
> -	list_for_each_safe(pos, next, &nn->client_lru) {
> -		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> -		if (!state_expired(&lt, clp->cl_time))
> -			break;
> -		if (mark_client_expired_locked(clp))
> -			continue;
> -		list_add(&clp->cl_lru, &reaplist);
> -	}
> -	spin_unlock(&nn->client_lock);
> +	nfs4_get_client_reaplist(nn, &reaplist, &lt);
> 	list_for_each_safe(pos, next, &reaplist) {
> 		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> 		trace_nfsd_clid_purged(&clp->cl_clientid);
> @@ -5998,7 +6337,7 @@ static __be32 find_cpntf_state(struct nfsd_net *nn,=
 stateid_t *st,
> 	cps->cpntf_time =3D ktime_get_boottime_seconds();
>=20
> 	status =3D nfserr_expired;
> -	found =3D lookup_clientid(&cps->cp_p_clid, true, nn);
> +	found =3D lookup_clientid(&cps->cp_p_clid, true, nn, NULL);
> 	if (!found)
> 		goto out;
>=20
> @@ -6501,6 +6840,43 @@ nfs4_transform_lock_offset(struct file_lock *lock)
> 		lock->fl_end =3D OFFSET_MAX;
> }
>=20
> +/**
> + * nfsd4_fl_lock_conflict - check if lock conflict can be resolved.
> + *
> + * @fl: pointer to file_lock with a potential conflict
> + * Return values:
> + *   %true: real conflict, lock conflict can not be resolved.
> + *   %false: no conflict, lock conflict was resolved.
> + *
> + * Note that this function is called while the flc_lock is held.
> + */
> +static bool
> +nfsd4_fl_lock_conflict(struct file_lock *fl)
> +{
> +	struct nfs4_lockowner *lo;
> +	struct nfs4_client *clp;
> +	bool rc =3D true;
> +
> +	if (!fl)
> +		return true;
> +	lo =3D (struct nfs4_lockowner *)fl->fl_owner;
> +	clp =3D lo->lo_owner.so_client;
> +
> +	/* need to sync with courtesy client trying to reconnect */
> +	spin_lock(&clp->cl_cs_lock);
> +	if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags))
> +		rc =3D false;
> +	else {
> +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
> +			rc =3D  false;
> +		} else
> +			rc =3D  true;
> +	}
> +	spin_unlock(&clp->cl_cs_lock);
> +	return rc;
> +}
> +
> static fl_owner_t
> nfsd4_fl_get_owner(fl_owner_t owner)
> {
> @@ -6548,6 +6924,7 @@ static const struct lock_manager_operations nfsd_po=
six_mng_ops  =3D {
> 	.lm_notify =3D nfsd4_lm_notify,
> 	.lm_get_owner =3D nfsd4_fl_get_owner,
> 	.lm_put_owner =3D nfsd4_fl_put_owner,
> +	.lm_lock_conflict =3D nfsd4_fl_lock_conflict,
> };
>=20
> static inline void
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 498e5a489826..bffc83938eac 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
> #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
>=20
> #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
> +#define	NFSD_COURTESY_CLIENT_EXPIRY	(24 * 60 * 60)	/* seconds */

EXPIRY might be confusing in this context. How
about NFSD4_COURTESY_CLIENT_TIMEOUT ?


> /*
>  * The following attributes are currently not supported by the NFSv4 serv=
er:
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index e73bdbb1634a..a0baa6581f57 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -345,6 +345,8 @@ struct nfs4_client {
> #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
> #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
> 					 1 << NFSD4_CLIENT_CB_KILL)
> +#define NFSD4_CLIENT_COURTESY		(6)	/* be nice to expired client */
> +#define NFSD4_CLIENT_DESTROY_COURTESY	(7)
> 	unsigned long		cl_flags;
> 	const struct cred	*cl_cb_cred;
> 	struct rpc_clnt		*cl_cb_client;
> @@ -385,6 +387,10 @@ struct nfs4_client {
> 	struct list_head	async_copies;	/* list of async copies */
> 	spinlock_t		async_lock;	/* lock for async copies */
> 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
> +	int			courtesy_client_expiry;
> +	bool			cl_cs_client;

Why is a separate boolean field needed? Can this be an
NFSD4_CLIENT_ flag instead?


> +	spinlock_t		cl_cs_lock;
> +	struct list_head	cl_cs_list;
> };
>=20
> /* struct nfs4_client_reset
> --=20
> 2.9.5
>=20

--
Chuck Lever



