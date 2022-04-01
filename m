Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A08D4EF7DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 18:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbiDAQaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 12:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346034AbiDAQ1x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:27:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A357B239;
        Fri,  1 Apr 2022 08:58:00 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231FuIpG026804;
        Fri, 1 Apr 2022 15:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=o6XK7N/4392+MreAV0hyXNH53X0vBqJRhAMSwfbbSBg=;
 b=x84NDVtHZD21rj2hkCONTLTB5xAzVcJenk45MRnK7tYYlhsEd0QV6ceyPloUhccrsD/1
 1r+/2uMksCIe43TrcGq7S3hDvALXhNkCWzph3K4+yxyVtgjynML5l8pz07Cvk5YxBZQs
 VQvJNQlW4Bxm1wAZBLHQGVDboIRKG4JV0NAtTYQ7L1aVNjkvoHMADzXsxWmrMi8MpCmw
 9ST4tw3oUN9vJXq8WXYdY9Q9/jXhJxg+1UKRkB5sWZnohAGiaCQpmi3zcjGpxnvj5jfo
 uyAQSmiYbUwc1qanJiJGwPIbhReU+fOmEeOEid1zgwS6Q2PBraoqptUo7SoaaQnjKrPF WQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tqbf5ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 15:57:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 231FucWw004354;
        Fri, 1 Apr 2022 15:57:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s95x2v0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 15:57:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jd7erdXq9Fn5zy6f9+1/dWnr9cZDFMqTDQ5zK3/HyHBF/23fZIrTiFHOHAH2mpVNdT/rSKebUJ7koI9T/7sYRM0/rlZfNoSv1BktGCeqlgIExdDYZ7JOSq2Z4tRFJygAsuyo9c9FX6bAlXrHr+HCDSd+Z+PWv3lUaSO44DQFDZAqrfdzFQ55lfg2PvHGW6p7VirvVYmoMpggEj0XeH1p7ZxfzluAAIbIjwlQvQeafOuWZY2IHs/L9xoMzbKntM9i62yOl5rHGzSg5ypFewjvJsxIAHA6gr4atjQgtdpRGiPoBucjmWvC+d74Wc6m8UTItUpTNxjJCFoisFqAFmKF5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6XK7N/4392+MreAV0hyXNH53X0vBqJRhAMSwfbbSBg=;
 b=cqfx4biMWexdmd/lyUH9ahujfb5lMep8rlun8IlduyMtdvVF2g1uxBjjXYtNBbcfSH4XUqfYexOd6jAHwmYLha/wmIidcNPyJj4pt8zWkyRnEaFKYwNi4qjcWQ1Gr84g290eRVgkJ8i3rqPAu8Oh5Z4y7GMzE8zhiPXYPBBlIlMSN3yG7y6gYcwl/UDf1TrYJHqFp+7r4cZ5GvRNO3G0RsJmFme9SNDvDQd+8uLVJymsjSSVmkXY/CXV+xpMcsBeqOfEF5sB+4w8rU88RDxTizScC2RN6/9OYziY+pCbYM1pngFnn40dFxrBfqOD5UPnQOF1lBIw7Cdpy1nVrY8W8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6XK7N/4392+MreAV0hyXNH53X0vBqJRhAMSwfbbSBg=;
 b=bRzqEjNOu1STOEA7zoM5lSgUW4ODv8TMlH50wMv+s2tWCzCLntwBapE4Iba0LChx3Gbj1SKOjHnKAMQIXrm3n9P6WPCv7LyGqRd0qSEHYBhf/ux7V4400wDme4GInUaqkJAklMHvlX6xXjodwHds9WB7j3XCBYXsbP+zkNx408o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB3876.namprd10.prod.outlook.com (2603:10b6:a03:1fa::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 15:57:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%6]) with mapi id 15.20.5123.026; Fri, 1 Apr 2022
 15:57:50 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v19 06/11] NFSD: Update find_clp_in_name_tree() to
 handle courtesy client
Thread-Topic: [PATCH RFC v19 06/11] NFSD: Update find_clp_in_name_tree() to
 handle courtesy client
Thread-Index: AQHYRRiz4DLghbl5p0mDl+lBwBV++6zbLgiAgAAKP4A=
Date:   Fri, 1 Apr 2022 15:57:50 +0000
Message-ID: <52CA1DBC-A0E2-4C1C-96DF-3E6114CDDFFD@oracle.com>
References: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
 <1648742529-28551-7-git-send-email-dai.ngo@oracle.com>
 <20220401152109.GB18534@fieldses.org>
In-Reply-To: <20220401152109.GB18534@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e85c1436-cdcf-42b9-6406-08da13f85fb8
x-ms-traffictypediagnostic: BY5PR10MB3876:EE_
x-microsoft-antispam-prvs: <BY5PR10MB387671FD3D755EA0FC7BAB0893E09@BY5PR10MB3876.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jau0LaNezLkrUo+98EHsj9cXNHnu6tF0NIEHgRsKs9mog1n62yrw3iv81KAF/ISvIvVLCm5icJio6MgYQamR0GBmaLrju2A7qkP7jln6OvKzH4xxPeM/StJSy7NEobVEzjQcSUwBuM8t5/stji27mHqdAY2kZKr0dUh5FjLmNTXaPaurEKAnjEz5jMBYBMXWaHOggQ2xi9onjawlzrcOwUyeFHqAbi3y6il7lwLL5GTv9T9gC2WCGtTLMFIHi1mAPFL0l7Erap7wCRASuT/F50DBogMuUUeXewkEJUjIfKGAeougSxfROzN8O/O6HKor3SNtn0MP/0/cev7MWvX+72/VHlCr4TUZ85r0jD69xeIezPhgEz2Cv/i9u1N0b0bum7yXcO7tQ9VH03vDg0wwW7LDV/V3SnNHqx8C2yaVJ/Zh1Dh6S7mvLDwdeGZRu9Oti8lk91jCqphJXndWT5Kfer8+eK6u1RTHUFgWThECpZUMyfWx0JPUIgoZczf+YrlpqdjjhbT1oIdASL1SIhapbXikhxPey7J46gXEplWWSxEEQE52EMbZ9x+g6WqTr8yaz+XmV3PHcryKKjv8WerjTVfR7bjtIOw+MNGJvpFiNpPeyRld155V3PuSgeiSxIoLCdS6/aZBq0pGzsA3ec6LrLiMOBty1xF2nSvHncFDYvstSC+Y9iQqq+TZvYW4Aapu7wedDaLrkGJ3tCh5qmO2m4fUxdOoAJM4cemDVDpVrPdGuPlzL/Ni+qdQLDXLuoCu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(38100700002)(33656002)(5660300002)(71200400001)(8936002)(6512007)(53546011)(122000001)(86362001)(6486002)(83380400001)(76116006)(6506007)(15650500001)(2616005)(38070700005)(186003)(2906002)(6916009)(66476007)(66946007)(66556008)(66446008)(91956017)(316002)(26005)(54906003)(4326008)(8676002)(36756003)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E7n+gt1Ps5xlS5surYmKtLejM1LrjlIpcAMAqe0AxCJ1jhru9Rq4TdRfyKRP?=
 =?us-ascii?Q?wViYMa8fjXmwtS8kAA49HTmO7awHQKTrTl7MhAHRmiPd47d4nV9c+gaYWI0x?=
 =?us-ascii?Q?+KtEpoM0LuxhvD13zCd3Z9+t9tU7hCaLleDCQItTn9qF/7rSleByZTidfKEQ?=
 =?us-ascii?Q?Lkbd7KEEz/qXXv5WvOtCtI5wwbbZgNMctbdgE/lWYKNGo1nz0XWJUy54b116?=
 =?us-ascii?Q?1tLqwsO1YDMfCUPRCcJnpocKucZGZDoMz5SFrUpe8d7Kt7HyaapWarFhgox3?=
 =?us-ascii?Q?lIh5Fv4dCZ9EaXFjEIolFVuDEKedNg4lbmN++hIGFmfR4fmKXA5i9L6piu+M?=
 =?us-ascii?Q?jQhSOWUjE54j0VRxX/l2cxbl6u2dT6g8h57+X0OpBdRIon2+ALCxG0IvUgnk?=
 =?us-ascii?Q?PaeDCWLN8GHT4F/mJyuB9Rx77Tkf6eRMiXYY78bRdwFH6T6SREnO/0V0KQbe?=
 =?us-ascii?Q?xdnXMTmGgpxaqEDsdVr7y+Pyne8ZMc4gU8a9N9X48nNUvivIsiSNGKenH5O7?=
 =?us-ascii?Q?XF2fYAmeEsQsqZLxVOTfKQbRwb6WrHUznJOmsDtvx4W5myz3iqy9nJ5eceJN?=
 =?us-ascii?Q?FaDeJyXOT3xSdd536uCPvKIwL+Mtnvi2Mx3B81lHodYfaX6QVa0wpqWkVrOD?=
 =?us-ascii?Q?M0zzpS7ckgo6LPpoc1x7Z8wGGs2ZFJJ/H870/hd3b96bX+6n2ZZa7hAk2pK7?=
 =?us-ascii?Q?evBlTRCzCf6BH7/lD4c8PDw8697v5SXgGBCHs5BI4C2WqTHeGtPABzDl1WSh?=
 =?us-ascii?Q?JR5yhQQMFTgof1inFNVtBkIyTK7qT3BavKb6hFvjagC4Yy60BcFlR68fGOnL?=
 =?us-ascii?Q?11aH8jCC72UHJqfcaL5U3ZmnpekJHZ/bI2geMPkHjy5cI673urREvfXT+gzX?=
 =?us-ascii?Q?clT+mOw7Tjq4RkilyRC2U7tW6y9VTVl4BAk6E5oyxMqySswjR3l10TsLHDgh?=
 =?us-ascii?Q?XgOskx6T558VCsuiAMkJL6WUAVQQJ3719qRNYfuzJLPSWH4o+4LSYzAC/AAI?=
 =?us-ascii?Q?TYIEMvTUgUyhRxKLHwqCu2cISmIeIF/R1BmOf7PfezTiNQYIIkAenMo/+LCw?=
 =?us-ascii?Q?ds2uJnDoaPD4TAY0bfjglJeDyRNUoBBe/XqqVBo0Imkqvlkd/1tDs6F0HX3I?=
 =?us-ascii?Q?uc57/bQ/ESn4RnlylKL0Z2OskptzjC3rLU/JKBa7veEoaUnTNRjbksLipMcy?=
 =?us-ascii?Q?jJZRSl6TDFAkORH/y8+PeFYfZ9nrrqfbtt7y2HDY7CqRGUOXFnyH8lUfpzGg?=
 =?us-ascii?Q?xyHvousua0Sk8/JvKDhrmbtc6/Nav4MGeNonPaiynKGvcAT5hFPRR8hceegE?=
 =?us-ascii?Q?vHUURL10mXLG1SNgQ/kievpSZdEF006ETaD4Wg9TuCQmVld+f7m6iu/ODvRn?=
 =?us-ascii?Q?biGwztnbeITqOoJGU2c++AHKt+IzgOAq6qgOAQTbYLbSsz2QoP9Rvg/kK/fj?=
 =?us-ascii?Q?HkYrdpt8qOJcVYF40C0ZORmXOdLVhP/VzXYnaYmh8/GymJzVaFHXY52WctKw?=
 =?us-ascii?Q?y46wy1m9rr1Lsn5HOEJlq08267pv30VpfXwAJweR/7xBc5UdhmHRxoMlhriV?=
 =?us-ascii?Q?MsKgWr3vwKfibAvufsdm09NNpl33bhhxLtxjAyTqY/LroRHKovj362gXuggk?=
 =?us-ascii?Q?KRxqIybNCzAUzg7WSxe35bznA/xRp8zS7k280YHSE4yRZ57SO06CRyBa1ERR?=
 =?us-ascii?Q?3wKZfmrAVturF+abjg0duDOPx3H/27JwsPXuL+f3/FhsgsmAP5cv4UEVqAOu?=
 =?us-ascii?Q?/4xG92lvI5xJDoGonX/pSNL8CVRDtpc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0EC5A8171AF27C41A3E4F1F0FD3DD00A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85c1436-cdcf-42b9-6406-08da13f85fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 15:57:50.4146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ptnUx6/2JErG3nfJfMHyFpd8HVannFlLVWA4TzSPZH/YLRQkDfO8x0RRF8uni1i2HGEQrpJZnf6LsAUnXFLWkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3876
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-01_05:2022-03-30,2022-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010077
X-Proofpoint-GUID: fouTvWnicoYEo7w-th0eXd_29ySMuPKf
X-Proofpoint-ORIG-GUID: fouTvWnicoYEo7w-th0eXd_29ySMuPKf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 1, 2022, at 11:21 AM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> On Thu, Mar 31, 2022 at 09:02:04AM -0700, Dai Ngo wrote:
>> Update find_clp_in_name_tree to check and expire courtesy client.
>>=20
>> Update find_confirmed_client_by_name to discard the courtesy
>> client by setting CLIENT_EXPIRED.
>>=20
>> Update nfsd4_setclientid to expire client with CLIENT_EXPIRED
>> state to prevent multiple confirmed clients with the same name
>> on the conf_name_tree.
>>=20
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c | 27 ++++++++++++++++++++++++---
>> fs/nfsd/state.h     | 22 ++++++++++++++++++++++
>> 2 files changed, 46 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index fe8969ba94b3..eadce5d19473 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2893,8 +2893,11 @@ find_clp_in_name_tree(struct xdr_netobj *name, st=
ruct rb_root *root)
>> 			node =3D node->rb_left;
>> 		else if (cmp < 0)
>> 			node =3D node->rb_right;
>> -		else
>> +		else {
>> +			if (nfsd4_courtesy_clnt_expired(clp))
>> +				return NULL;
>> 			return clp;
>> +		}
>> 	}
>> 	return NULL;
>> }
>> @@ -2973,8 +2976,15 @@ static bool clp_used_exchangeid(struct nfs4_clien=
t *clp)
>> static struct nfs4_client *
>> find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *=
nn)
>> {
>> +	struct nfs4_client *clp;
>> +
>> 	lockdep_assert_held(&nn->client_lock);
>> -	return find_clp_in_name_tree(name, &nn->conf_name_tree);
>> +	clp =3D find_clp_in_name_tree(name, &nn->conf_name_tree);
>> +	if (clp && clp->cl_cs_client_state =3D=3D NFSD4_CLIENT_RECONNECTED) {
>> +		nfsd4_discard_courtesy_clnt(clp);
>> +		clp =3D NULL;
>> +	}
>> +	return clp;
>> }
>>=20
> ....
>> +static inline void
>> +nfsd4_discard_courtesy_clnt(struct nfs4_client *clp)
>> +{
>> +	spin_lock(&clp->cl_cs_lock);
>> +	clp->cl_cs_client_state =3D NFSD4_CLIENT_EXPIRED;
>> +	spin_unlock(&clp->cl_cs_lock);
>> +}
>=20
> This is a red flag to me.... What guarantees that the condition we just
> checked (cl_cs_client_state =3D=3D NFSD4_CLIENT_RECONNECTED) is still tru=
e
> here?  Why couldn't another thread have raced in and called
> reactivate_courtesy_client?
>=20
> Should we be holding cl_cs_lock across both the cl_cs_client_state and
> the assignment?

Holding cl_cs_lock while checking cl_cs_client_state and then
updating it sounds OK to me.


> Or should reactivate_courtesy_client be taking the
> client_lock?
>=20
> I'm still not clear on the need for the CLIENT_RECONNECTED state.
>=20
> I think analysis would be a bit simpler if the only states were ACTIVE,
> COURTESY, and EXPIRED, the only transitions possible were
>=20
> 	ACTIVE->COURTESY->{EXPIRED or ACTIVE}
>=20
> and the same lock ensured that those were the only possible transitions.

Yes, that would be easier, but I don't think it's realistic. There
are lock ordering issues between nn->client_lock and the locks on
the individual files and state that make it onerous.


> (And to be honest I'd still prefer the original approach where we expire
> clients from the posix locking code and then retry.  It handles an
> additional case (the one where reboot happens after a long network
> partition), and I don't think it requires adding these new client
> states....)

The locking of the earlier approach was unworkable.

But, I'm happy to consider that again if you can come up with a way
of handling it properly and simply.


--
Chuck Lever



