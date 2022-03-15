Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B716F4DA168
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 18:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350653AbiCORkp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 13:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350640AbiCORko (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:40:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602CB58E41;
        Tue, 15 Mar 2022 10:39:32 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FFaZ3b029144;
        Tue, 15 Mar 2022 17:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=dYP1RVFWJhCVWoFuFo/RRRLH78lDuQgxFgGuh1Jbke0=;
 b=ntvmz2mFL/MhaG3i6IweEHiTBl9Lv+WtohwVJBw//dQ/OAMy2n1B2bjdKMnKviY+xk6W
 5XYgAFY+u6efbQHyGHrPQPKJyHxB+Vu+PfIx78w2d21ePOLf/mCSKgQ7+rhUsNmqi+dK
 uu+faY9ef++QXZ+fN8ht15hCGZ0e0U/b5qKGoYGAollcWET+lEor1QeLaJQoKj4ZyKDh
 KGlxHIetfH3HOn2jdzvbubEb6K3nFcAVOqy+ydq2RPpt79B1b/H9SWgCFpbezEoclzyu
 MK9eTdJODwy1j9kKENgaaJydeP+WdSJguE7+k1wBfPPaKC0Cb2lL3YZX2GO0QLf43z7D 4Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwkrym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 17:39:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FHY9EM012212;
        Tue, 15 Mar 2022 17:39:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by aserp3020.oracle.com with ESMTP id 3et64k547a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 17:39:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P17erk0XLyk+7qG65VIwaF9TDhegPKshSw0Lwu4nDMJQYxf/qBRdwLU2zRmhLGFg9KSF4rLNSM9d9SariJ+SW6cBiAuEEUgJY4BwFUS6obEUD31gE2S6A9sFEqh2u+0/PnIFjFZc04Q8rCeum6s91DWsN2A0D7OMQQ3g5a8R19u7A4QmKiGpA1VTD/CHvBkoND2aiIUskAu625kjnYa4G2dp+gIONG23wabVDKdOE1s1CuOnuYF8ZwZCo1RUGiiaIts8UPM/S8DDh8uw21HSWX/lNaHdpRxWgCJfB3p2k7V168RaCQDaanca7NYIXYLLOMae5efUHPXRTXzirXunEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYP1RVFWJhCVWoFuFo/RRRLH78lDuQgxFgGuh1Jbke0=;
 b=WGf0aXl1RH/CrBxT0BzzaBrV7ELz9eI6JT7Cpb14IVUsdiA5q4+qySa0+dFi6exU6JK8GVrZ7r2qll0T7mvAjASspc/0a8sutuhD+IXZfD+yBeBlQL/wbeBoO4C0qBFSxGD7MfPl7aBrBaeT7p+YvSM2cXnhPk5UIwbiQfB1+1+jBJtU7EPpO6PxN53JI8HQT6RT31BFGChteBVphDOXrtxWVLbS1vKEgqpSOIAyp6nTfi1YF/O+UpiADsBkW2kN9NYe6EjyekJD1O31AriDL8WynPfvJqNMldVyus2R5U8KAkg6epUK6Kcv+56vc7+Bix6TKLPHD8zJASIXyTdIqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYP1RVFWJhCVWoFuFo/RRRLH78lDuQgxFgGuh1Jbke0=;
 b=skYVj4UgGAGLGRyrxERuXGMeO5SjpkodeksN+pnohemyTavYvXp8D7566dNsTyYr1BpBdjXiWyXikPxWJwvP1dMosO++EzdJmjj1QNLXJQ+ZSTPtNhA4WToBRDUU+rJPdYkJBFT5p5htCSzb6XajzX84xtaQO6Qq76PaohH3O00=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5809.namprd10.prod.outlook.com (2603:10b6:303:185::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Tue, 15 Mar
 2022 17:39:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%5]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 17:39:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v16 03/11] NFSD: Add lm_lock_expired call out
Thread-Topic: [PATCH RFC v16 03/11] NFSD: Add lm_lock_expired call out
Thread-Index: AQHYNbbOvKvoIwrjEUGDuPSSbgMGUKzAkAaAgAAXeQCAABRNgA==
Date:   Tue, 15 Mar 2022 17:39:25 +0000
Message-ID: <483E025E-E72E-4F2C-BF98-66DE12F94909@oracle.com>
References: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
 <1647051215-2873-4-git-send-email-dai.ngo@oracle.com>
 <20220315150245.GA19168@fieldses.org>
 <1e1ff6a1-86cf-99d4-13ad-45352e58fe73@oracle.com>
In-Reply-To: <1e1ff6a1-86cf-99d4-13ad-45352e58fe73@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6b525a6-ca7e-436a-400c-08da06aabfef
x-ms-traffictypediagnostic: MW4PR10MB5809:EE_
x-microsoft-antispam-prvs: <MW4PR10MB5809C963DC38893559678B3893109@MW4PR10MB5809.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c7Qypqj+pFF4sQG77M5co11VhnIdvD3UQEbcQAU91l0qr0m50NijYaj909M7QJobNMwlR53jHlYHfZvtMKY3SzGB+4Hj4XrlfChrCI5NsS1XLuPqdk4R28hoQINYZNlPmU0u5E/vUlpFJ9Lr8frF+iM/UlvHuhgRqxla40UNUudYTF6Y96/djE5dNGz45OxP2cu2wM/qyRJzf2AUvEU1WJrsnYylCa/MrWrwwpPr1AE1WWTgmf0iXpkZ+Lp3uSgEMeeOe9TswSMn2llV70SfXYOHas0/PICemrI2R6csxAU276IfSizQbtwcldIVwZvzYp57wV9iLWlUh84qj7Is/WNRlmQmAi68SNGN4fcaIXOYtibwM7IZb1lQuVQffNkZ998uvr/p8a5BpVx0YDzmQ/1HvvAW48e8msE1q0gZWyNUFUaLgwkaZZM8auvJ8HMXwCT4UIJcvVYPuAHGgvC95YEt/2M0YsJubNvvJwiaGoUzPilTMgFwrAAkGis/F/EEAcS+rXdNJaGfhlrDaYmIKGQlUzA05mDjynGIpzzIXoFRufEkN+NbjB5mtCCa3v0dWUlapP+xX8qdLtINexEiaEyTZAlo+XJX5j/rgRjVlGu0CT7Zx6IGiprayeeyOtnK0HgE39XPw2yDsLzbu8ti8Lqif9Xql2/rxKaHijGmY7GzkRXr+1Z2ErYh0dUtTDmWrjLtqFSls8/puieI3nCM+W+Wd17zZ9mTtIfSrH/xCYSMy+oY/new/oiFTcK+TYM9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(38100700002)(8936002)(71200400001)(66476007)(66446008)(76116006)(66946007)(508600001)(6506007)(53546011)(5660300002)(26005)(33656002)(64756008)(66556008)(186003)(6512007)(6916009)(6486002)(36756003)(122000001)(54906003)(2906002)(83380400001)(91956017)(316002)(8676002)(4326008)(38070700005)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lnTaMdbQUW4TxIhxqtYmNSCzl3KrmEIsLIwSEiHiPe8jlbcye75dyy+R5yA1?=
 =?us-ascii?Q?VezUP3KQ+ImqgA/cUCJRvILwW49/KmlJWVw3WhnV1OcLrfJJsNG09tq32NOE?=
 =?us-ascii?Q?i6ahR7HK8GLaLfZdf+CPWSsPxtSsf2WFUi7Mwmvxs5bcNfzZtVz0rqzCZMDG?=
 =?us-ascii?Q?NWsq4AC8U083BiI10vl3Kqj2SJD9XDs3KWq5tBYSPwY9g96Qv7iS8lWa2cDV?=
 =?us-ascii?Q?/+nooCqDYNA6HRXFGRgPP7aq7Z4/adeuaRMyVuBz20PWJl/Jfbsf+Co4F9oO?=
 =?us-ascii?Q?1THaGQPrXTo+UOptdQKqk2i39Toj78R0eXvuk7FGooTPCpjLEUYo21ITH4RV?=
 =?us-ascii?Q?9wqCrdQoMT0AhPHnfoKu1o5Q64AufDExudQkkEyDBoLpH3uyLfVLofyB87Uc?=
 =?us-ascii?Q?/fNmOvbSTRsC6KK2fA9wh9JuYWOnU6U1rHe0l+HohlJsOh++Ct8QvSVmYLB4?=
 =?us-ascii?Q?nS0T/A9+Cdpmme34ym0xEmBwYm7k6NmXewEdRIk1/hwxyabJRNvjP8Xay9vi?=
 =?us-ascii?Q?ONxjdPBM6CREH1puCVUmpIXC0Jz+aQXDx8yeLo0X9iiYD7j4FEOYqFhMAUHU?=
 =?us-ascii?Q?DTGLG0VRWsOf5914wBWVnK01UxVYQ66oGYDE3pSjm5sU6L0F2SIejp8V4dBT?=
 =?us-ascii?Q?lpMs7N0bYnfvh9kwTSzmQ6qYMaPsdOf7EDDPygV+KWccYzwCsOpQ/2SEyjOt?=
 =?us-ascii?Q?GbSI791eMYL0ysD1AdEMBWyBmKbJ/KymJ2Fo6lBj8g2rMiMf/3Y3phIdENLx?=
 =?us-ascii?Q?8hlbK/d6D7Wv2zx35nxdkbRpCjuY2Ax2g1LSxSpirpn7IaVue30fRZpbFyKw?=
 =?us-ascii?Q?mEp3x7Bwqqv4tXE9xYFuqe19GRr5lkOyC7EVGsUJYkGfSuxTSCIAFOLG2VEg?=
 =?us-ascii?Q?ejBj2fRFOhkyAWbtjLo/hL8YhMXBoE7kkeOrqMP2TlBybyS9b0//gLl53W8c?=
 =?us-ascii?Q?o19iEtWq4hxn0eQ78iPMYpQM2ak3YUA/xtsWVosrwnH7W7OYfZsbCXI2oAMz?=
 =?us-ascii?Q?TctOGUvWuwHZ0LN9MIVUcPBAQTPSJ8YA5J6HhL7t0AafpeFKOgRd9RzxWIL4?=
 =?us-ascii?Q?ytiu4KBu7SXtCUGVZd8HrDMnwJXDFYfFOhaLljz+5hzOOXJjwUoVTcjEp18v?=
 =?us-ascii?Q?U6Tb+pUlhK1mLkQljWKS9CDBcjkm0oQAF2dh8d2B07mriAonchbUFPOsyBrW?=
 =?us-ascii?Q?yBoNE7Njq2V9zN5RXsfbPSI4oKt78M9svY3UEEjS9XZXN6rS8OS91wY4fq5E?=
 =?us-ascii?Q?jr58gmxw+3TYnN5WNDPlk6DaZQjlqaA1z3nWHa07qZNB5zlf/8wb9Mce79Bs?=
 =?us-ascii?Q?p5bZeS9WF4Qst0CmZUPR5k+j4xX7tnxb++jihPWzqJCQv3/MU6v+mv/v6JYy?=
 =?us-ascii?Q?ffrqScpLCi/xs68x/OhlaonBX9ek1aNHbs1NhD5VYm7fPOgO2dCNj4Z7w5Pc?=
 =?us-ascii?Q?wco9eXgBTsiOBSlUdPVMu8MIiMiQEk6sqfD3BnGJXg4iaFe6GMuBcA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <667772992AEE3840A743BA807B274C78@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b525a6-ca7e-436a-400c-08da06aabfef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 17:39:25.9900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AfwQZnk0xIaQ0TmTNY2wOgpbQNS5nBEQPZiW5i+tKm9iMEixOWtcOcynztXIXhvWXxGW1umnwkNI64XwLJGWFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5809
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150106
X-Proofpoint-GUID: tLqqK-rQG7XeJNwVDSLKxC_t8hyAUvZ2
X-Proofpoint-ORIG-GUID: tLqqK-rQG7XeJNwVDSLKxC_t8hyAUvZ2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 15, 2022, at 12:26 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 3/15/22 8:02 AM, J. Bruce Fields wrote:
>> On Fri, Mar 11, 2022 at 06:13:27PM -0800, Dai Ngo wrote:
>>> Add callout function nfsd4_lm_lock_expired for lm_lock_expired.
>>> If lock request has conflict with courtesy client then expire the
>>> courtesy client and return no conflict to caller.
>>>=20
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>>  fs/nfsd/nfs4state.c | 37 +++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 37 insertions(+)
>>>=20
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index a65d59510681..583ac807e98d 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -6578,10 +6578,47 @@ nfsd4_lm_notify(struct file_lock *fl)
>>>  	}
>>>  }
>>>  +/**
>>> + * nfsd4_lm_lock_expired - check if lock conflict can be resolved.
>>> + *
>>> + * @fl: pointer to file_lock with a potential conflict
>>> + * Return values:
>>> + *   %false: real conflict, lock conflict can not be resolved.
>>> + *   %true: no conflict, lock conflict was resolved.
>>> + *
>>> + * Note that this function is called while the flc_lock is held.
>>> + */
>>> +static bool
>>> +nfsd4_lm_lock_expired(struct file_lock *fl)
>>> +{
>>> +	struct nfs4_lockowner *lo;
>>> +	struct nfs4_client *clp;
>>> +	bool rc =3D false;
>>> +
>>> +	if (!fl)
>>> +		return false;
>>> +	lo =3D (struct nfs4_lockowner *)fl->fl_owner;
>>> +	clp =3D lo->lo_owner.so_client;
>>> +
>>> +	/* need to sync with courtesy client trying to reconnect */
>>> +	spin_lock(&clp->cl_cs_lock);
>>> +	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags))
>>> +		rc =3D true;
>>> +	else {
>>> +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>>> +			set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
>>> +			rc =3D  true;
>>> +		}
>>> +	}
>> I'd prefer:
>>=20
>> 	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags))
>> 		set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
>=20
> we also need to set rc to true here.
>=20
>> 	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags))
>> 		rc =3D true;
>=20
> With v16 we need to check for NFSD4_CLIENT_EXPIRED first then
> NFSD4_CLIENT_COURTESY because both flags can be set. In the
> next patch version, we will clear NFSD4_CLIENT_COURTESY when
> setting NFSD4_CLIENT_EXPIRED so the order of check does not
> matter.
>=20
>>=20
>> Same result, but more compact and straightforward, I think.
>=20
> Chuck wants to replace the bits used for courtesy client in
> cl_flags with a  separate u8 field so it does not have to use
> bit operation to set/test.

Code audit suggested there are really only four unique
combinations of the bit flags that are used.

Plus, taking a spin_lock and using bitops seems like overkill.

The rules for transitioning between the courtesy states are
straightforward, but need to be done in a critical section.
So I suggested storing the courtesy state in a lock-protected
unsigned int instead of using bit flags.

If we hate it, we can go back to bit flags.


>>> +	spin_unlock(&clp->cl_cs_lock);
>>> +	return rc;
>>> +}
>>> +
>>>  static const struct lock_manager_operations nfsd_posix_mng_ops  =3D {
>>>  	.lm_notify =3D nfsd4_lm_notify,
>>>  	.lm_get_owner =3D nfsd4_lm_get_owner,
>>>  	.lm_put_owner =3D nfsd4_lm_put_owner,
>>> +	.lm_lock_expired =3D nfsd4_lm_lock_expired,
>>>  };
>>>    static inline void
>>> --=20
>>> 2.9.5

--
Chuck Lever



