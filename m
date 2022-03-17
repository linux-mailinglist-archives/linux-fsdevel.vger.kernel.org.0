Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB39D4DC97D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 16:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbiCQPE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 11:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiCQPE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:04:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B995FBA;
        Thu, 17 Mar 2022 08:03:10 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22HDPAbn005595;
        Thu, 17 Mar 2022 15:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=p8x88KJ0EFDgxEC2K3/IdRKnBrvTQwcqV5xa2tEEzq0=;
 b=CyGeb5oul26v9qgW4++VS64ts4D2E1h8d7BKJLp1WtRZdoQ1GHEnM16H3aUN8Ebj1016
 mt/3IZQnARGwl9QN1KhGXyTDbVBU8gpV/jhQXcqwrI/dgmTUTeRcZU4xdiOb8//JHeIQ
 tmr9c7YTNjAFXmqlcjIEv4s1quoQzqQOTZeqfvi1hor0gx4YQ15af/VTtcwXzdTP64Wd
 8/aFPpBwrAHNK+IN6idp/7ZWTcI8jB/sbnVDGGBW/mjDNnLZE41k5sksxZmy9b8FZ+Bc
 lYLhvLU0Zkl54klCdW7kbsdSnOdQgYmhQyqwlqtEaNdbg81RP1pEarRnqjHDRTzyNJ/z ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rsk8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 15:03:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22HEv3E4175212;
        Thu, 17 Mar 2022 15:03:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by userp3030.oracle.com with ESMTP id 3et65q2xwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 15:03:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqAZfEdVtZPmCMNavjLhjiMgw+TonVwZuqYFFXvU5ScqDJht5q6aFpV75IqXdLsSZ/cKBfDgFK7zJZWQz6/NtCpBbfyaneCRv/vHrJvE5vmBDyErK8F+aNTyQQwhykmg+27+aMNLqxzK4DqtJv2i3F7Q1u4uutwF23F1MkmCVzMZA7Vq58UlAZRgm55s5KeQlRuNDx/S5K7UruQFGknLEtRuun/L14oxmPN2owpJeHHyuXZ3mTMsRUXBY3qfdewNe+TLwLioh2b8NcNFWkq/9WPiTN8lrCHg/Twfyycl/tIUoS7F0OOOemvskBMh1Aihn/ImTyJiVunv+u34WX75lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8x88KJ0EFDgxEC2K3/IdRKnBrvTQwcqV5xa2tEEzq0=;
 b=ZQ/CC8+8yal91rpX2c3tgWO4/afLYz9sqpRooP8eb6mHuN3FM78JwtNdlTVuFKX9WDVXpwhqx7XrNj44Lp0RajZ4Xkys+gCfKSiMZE2W/TvWXiz9zLaup3F73VVYUsmu/E+rnk9k/bDXkVeWcBsgQMAWA+hTCEUVlCwCXQYXFGM5X7uKh6eDsYp0PRFaz1SJHPzyLtHUtn9dpa+pQVSJEVUD49GYmT/vTEQqNvHwdhvCs4uidIx4iILH98ZpZLJW12eSexnM2qmheP/v7+p0TH3jqqrpRHDdRBapIji5VlGSRFw0sJKEeoHnq3dHFG3L0+pMgz6n+NFeuGfXD9CDVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8x88KJ0EFDgxEC2K3/IdRKnBrvTQwcqV5xa2tEEzq0=;
 b=OJnlI/HwIwtGoKcqvCk4gPgdivtA0yMQkG9yL8/jqiwDp+OADJht3Fmpa4rCly/voaET3iHtBX8knR18wVFgh4l0FM6aDIBGSPgEdQtwi1nex0cFzqO6asaWQYw/sMA84WbDR15gAw5u99IvCOJ5pWnHa/eHg7aHZmk6AmclMk0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5813.namprd10.prod.outlook.com (2603:10b6:510:132::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 15:03:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%6]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 15:03:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v17 10/11] NFSD: Update laundromat to handle courtesy
 clients
Thread-Topic: [PATCH RFC v17 10/11] NFSD: Update laundromat to handle courtesy
 clients
Thread-Index: AQHYOdLGh7XSlU+PXEqeqUULeJ6GhazDrIuA
Date:   Thu, 17 Mar 2022 15:03:01 +0000
Message-ID: <3414885F-7F08-4005-860D-16EC94B106A5@oracle.com>
References: <1647503028-11966-1-git-send-email-dai.ngo@oracle.com>
 <1647503028-11966-11-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1647503028-11966-11-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65553b6a-26ce-4fb4-4fce-08da08273b63
x-ms-traffictypediagnostic: PH7PR10MB5813:EE_
x-microsoft-antispam-prvs: <PH7PR10MB5813F425BDD9BD9EEFCD716193129@PH7PR10MB5813.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AioRJVOZyECP2Ag25jKNBV+zLA1uu+RBJnrX0M8wHZXsYMHN6rhnfPihXzmQbnIfZA1Gqimuau1iA+6qAzjvLc8NTmTzdyTM9QiKBUxarxMlgH9vpOHSTBGhFqhJQnyHtQerFmoZdtqVHcg5nU9rGIruC8Rza0Ywu6iVMPaQ31tV4IkPvbfoQTMqB30fFQmg8eC16vy5DjILDu++qY2LjmxYxPKQAc/O93kdSWz1cOY8GyJB0XsvM2Kn6wB5C1KwPI0bveEGg/sJX5XenHHaSTfFSCkbwlrp+AfueKjW+R/KoGzUP9IySvIWqYn1agI+VneSKWaqz+2eo4XSAefBOrvEp9YofOytbxv/F45WO8g6i/1lNiFUZBBmQQuRbLpuaV2/W0IRF4mOrthuTOeydiWupVWkIi6t9tn9REvi1sm5XQJvDJg4HHPRfNp26dCCjeG1VnUbCOeP4bz6JChlyNAvYYOUp6Aa49Jvsc+4F8kdRX4oqKVY69Mvu2zzkWrPrxF0h8mqNwj/AEnO6PkgltJ0WMh5DzMT0fn3bvQ2wMEeyrxsEtzR42eq0iN3dJ0rp+Jom6SJXIc8JKbwX6UgMPFLrMKoi0ATyxZ7dO80HMUEkJvtZc4KD+kMaQPbzRQR93yq7hfaEZWO4JAGBMqPc1Xchk7mhKEGDyRLWRpXphQ2L9hltPTABGuQFtbyUoqizU79WEvg3IviUshR0k8mulvUG7HqR6yLkWpZJdno9E23tDnMORFb9ui4IDQSoYn0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(8936002)(2906002)(26005)(122000001)(53546011)(36756003)(316002)(38100700002)(186003)(86362001)(6506007)(83380400001)(15650500001)(5660300002)(37006003)(54906003)(6636002)(33656002)(4326008)(76116006)(66946007)(38070700005)(6486002)(8676002)(64756008)(66556008)(66476007)(66446008)(6862004)(91956017)(2616005)(71200400001)(508600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?88HJwKmBymn8QysdsLRiFI/dYQv3ubi1Q0TaDpg5eDg71r9G2i4lA8wwcPuv?=
 =?us-ascii?Q?aI0fnq/24ZzYT/uszuoP7og7oYjbws8xWEMGVKH+1cpUNzhX7vCGJc/M59Xr?=
 =?us-ascii?Q?FHa/4u3VjldD7nd2bQo9wqKvJ82RN7DVVKkZnk8LeCPrDU7ux4G7hi8n36jX?=
 =?us-ascii?Q?uhJdRPzxTTf9COQBzrJLVFXgwXkjecyh/pubSvX+vx5jP1o6pKIYL3+u1jRi?=
 =?us-ascii?Q?UN6z5XBGe1ZRggACnlP39W1h9n0eApWzwiko8KTOQON7EqePnN7waiQdmDa3?=
 =?us-ascii?Q?OMB+xK8+0kptZE2AtAdARZDNW5hiGIqprxuaeUwLKNuF6fOYALrHUhHLmA4g?=
 =?us-ascii?Q?fcB4P80aFVECuBx+O2JjjNLVD3B3q37CZM6wvrUL1W+c57LLGxeJI/lAg3u0?=
 =?us-ascii?Q?atV416xqlgWD/XlzHqv/406kmFABfSdqeL4uDoUY4q567O4D6nM7GHasfPVo?=
 =?us-ascii?Q?0BselIYwmblrFAQ0siCR0MkllGI9cmG8OweKrs62s5KjgcCEZsnsgiStoFLz?=
 =?us-ascii?Q?z8ED9r+J+frqkgsBvdPVU/5NxOEn5XkIt2oW12LSDoL67o97hdntd9e7JHVq?=
 =?us-ascii?Q?9t2R98lM4ONOzbKtAK4YUuVwmAIvI5iW4jkP+odog9Y4G4ABaq+fcEp7sirx?=
 =?us-ascii?Q?X7omzjW2oSMlNvslxDsayh9KT0qcfU7MclZKp43qVaq8HJ3id54L46L1qwrD?=
 =?us-ascii?Q?bt2LpJ1pKNxRurU6vpn12tMDGXbbyiZfeIhme2FOrYl3D4RTyLIH1Z9dNfcC?=
 =?us-ascii?Q?+656rm+1RknzCV6oV7T3JbvipzMTr9Tm2+jzMERLDFWE20O9f8uVdpRzIN7P?=
 =?us-ascii?Q?5kU5Stpy8WpGDU2lC6AL1XC5XVv4qwfG2sYLCtEXD6wrEwF1vlHzKduEzMX1?=
 =?us-ascii?Q?HN92pRvhQx1a6xHqTDi61oKVSmRHk39oQo2rEVMBR/+0MhifCR85ZiUV++qs?=
 =?us-ascii?Q?v8YAjGrHWTqCcWhxRvqKQvhqaq8hpquMDYPg3z+R3obDPcKPAiFzZKPI2pQL?=
 =?us-ascii?Q?bPlKdpcQkCDoN5lCIskZhtrDwPfZP/OELzOBtvId8xhsvs5qkASXQVcekVXx?=
 =?us-ascii?Q?22QezlSgeo+QFrvhC2hdW6bSd8dfxoslgaeguCDF+wsp6PpqPkHewbedg3fb?=
 =?us-ascii?Q?8jiHrfw3dmq50mH6LWFl6lN1VJ7zLj8orzsOh60pZ5T1w24edo2v/plrKIEs?=
 =?us-ascii?Q?NqZzBnAr/Plt+z/ELTvYxnmLQ5BJFaKbOf3xwboRsm8pQuedbke+nCoL6h6r?=
 =?us-ascii?Q?3IGsLzYUp46iJDe6VXJvzsh8J4B5xssBGKjBwDhCTKRT8/vQ07tecvgLt9V4?=
 =?us-ascii?Q?v8Biy3T7QhpJJvAxx2Zoan/gMNRK+IkAylty79u75jNBTdMUxf3kdWFEUaw7?=
 =?us-ascii?Q?k5CM3+coXh507KAymiWA8B6OBHplmBNWvS/SeLfKay0V7o+hlTdb2grptl6b?=
 =?us-ascii?Q?S5AXj1Eb5fMYHJbyGnSmTGew/rxW25hV3SsK7ur+DXzNfkqMhvGPqA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A094E744D458F84594DCC2C19952FC5B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65553b6a-26ce-4fb4-4fce-08da08273b63
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 15:03:01.8363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a5yRDxLaXP4WtLvDXOFY/zkaA2c6F/T9D/q/2XBO7XbpEvKzDtJXbGt6EptL9WgRALszkJzpVequIebH7SMEqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5813
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10289 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170088
X-Proofpoint-ORIG-GUID: 5WAdOlMSBffyyaozm11o-FUS4XruQ4Pf
X-Proofpoint-GUID: 5WAdOlMSBffyyaozm11o-FUS4XruQ4Pf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 17, 2022, at 3:43 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Add nfs4_anylock_blocker and nfs4_lockowner_has_blockers to check
> if an expired client has any lock blockers
>=20
> Update nfs4_get_client_reaplist to:
> . add courtesy client in CLIENT_EXPIRED state to reaplist.
> . detect if expired client still has state and no blockers then
>   transit it to courtesy client by setting CLIENT_COURTESY state
>   and removing the client record.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++--
> 1 file changed, 91 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b4b976e00ce6..d5758c7101dc 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5755,24 +5755,106 @@ static void nfsd4_ssc_expire_umount(struct nfsd_=
net *nn)
> }
> #endif
>=20
> +/* Check if any lock belonging to this lockowner has any blockers */
> +static bool
> +nfs4_lockowner_has_blockers(struct nfs4_lockowner *lo)
> +{
> +	struct file_lock_context *ctx;
> +	struct nfs4_ol_stateid *stp;
> +	struct nfs4_file *nf;
> +
> +	list_for_each_entry(stp, &lo->lo_owner.so_stateids, st_perstateowner) {
> +		nf =3D stp->st_stid.sc_file;
> +		ctx =3D nf->fi_inode->i_flctx;
> +		if (!ctx)
> +			continue;
> +		if (locks_owner_has_blockers(ctx, lo))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static bool
> +nfs4_anylock_blockers(struct nfs4_client *clp)
> +{
> +	int i;
> +	struct nfs4_stateowner *so;
> +	struct nfs4_lockowner *lo;
> +
> +	spin_lock(&clp->cl_lock);
> +	for (i =3D 0; i < OWNER_HASH_SIZE; i++) {
> +		list_for_each_entry(so, &clp->cl_ownerstr_hashtbl[i],
> +				so_strhash) {
> +			if (so->so_is_open_owner)
> +				continue;
> +			lo =3D lockowner(so);
> +			if (nfs4_lockowner_has_blockers(lo)) {
> +				spin_unlock(&clp->cl_lock);
> +				return true;
> +			}
> +		}
> +	}
> +	spin_unlock(&clp->cl_lock);
> +	return false;
> +}
> +
> static void
> nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
> 				struct laundry_time *lt)
> {
> 	struct list_head *pos, *next;
> 	struct nfs4_client *clp;
> +	bool cour;
> +	struct list_head cslist;
>=20
> 	INIT_LIST_HEAD(reaplist);
> +	INIT_LIST_HEAD(&cslist);
> 	spin_lock(&nn->client_lock);
> 	list_for_each_safe(pos, next, &nn->client_lru) {
> 		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> 		if (!state_expired(lt, clp->cl_time))
> 			break;
> -		if (mark_client_expired_locked(clp))
> +
> +		if (!client_has_state(clp))
> +			goto exp_client;
> +
> +		if (clp->cl_cs_client_state =3D=3D NFSD4_CLIENT_EXPIRED)
> +			goto exp_client;
> +		cour =3D (clp->cl_cs_client_state =3D=3D NFSD4_CLIENT_COURTESY);

I've forgotten: why don't you need to hold clp->cl_cs_lock while
checking cs_client_state here?


> +		if (cour && ktime_get_boottime_seconds() >=3D
> +				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
> +			goto exp_client;
> +		if (nfs4_anylock_blockers(clp)) {
> +exp_client:
> +			if (mark_client_expired_locked(clp))
> +				continue;
> +			list_add(&clp->cl_lru, reaplist);
> 			continue;
> -		list_add(&clp->cl_lru, reaplist);
> +		}
> +		if (!cour) {
> +			spin_lock(&clp->cl_cs_lock);
> +			clp->cl_cs_client_state =3D NFSD4_CLIENT_COURTESY;
> +			spin_unlock(&clp->cl_cs_lock);
> +			list_add(&clp->cl_cs_list, &cslist);
> +		}
> 	}
> 	spin_unlock(&nn->client_lock);
> +
> +	while (!list_empty(&cslist)) {
> +		clp =3D list_first_entry(&cslist, struct nfs4_client, cl_cs_list);
> +		list_del_init(&clp->cl_cs_list);
> +		spin_lock(&clp->cl_cs_lock);
> +		/*
> +		 * Client might have re-connected. Make sure it's
> +		 * still in courtesy state before removing its record.
> +		 */
> +		if (clp->cl_cs_client_state !=3D NFSD4_CLIENT_COURTESY) {
> +			spin_unlock(&clp->cl_cs_lock);
> +			continue;
> +		}
> +		spin_unlock(&clp->cl_cs_lock);
> +		nfsd4_client_record_remove(clp);
> +	}
> }
>=20
> static time64_t
> @@ -5818,6 +5900,13 @@ nfs4_laundromat(struct nfsd_net *nn)
> 		dp =3D list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> 		if (!state_expired(&lt, dp->dl_time))
> 			break;
> +		spin_lock(&clp->cl_cs_lock);
> +		if (clp->cl_cs_client_state =3D=3D NFSD4_CLIENT_COURTESY) {
> +			clp->cl_cs_client_state =3D NFSD4_CLIENT_EXPIRED;
> +			spin_unlock(&clp->cl_cs_lock);
> +			continue;
> +		}
> +		spin_unlock(&clp->cl_cs_lock);
> 		WARN_ON(!unhash_delegation_locked(dp));
> 		list_add(&dp->dl_recall_lru, &reaplist);
> 	}
> --=20
> 2.9.5
>=20

--
Chuck Lever



