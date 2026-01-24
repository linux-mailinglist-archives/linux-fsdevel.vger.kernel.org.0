Return-Path: <linux-fsdevel+bounces-75332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uANyCYsTdGkh2AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:34:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B84927BB18
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC3EE301CF8A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 00:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740B01C3F0C;
	Sat, 24 Jan 2026 00:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/VepZ6S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA41712FF69;
	Sat, 24 Jan 2026 00:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769214844; cv=none; b=iEafTQAxCaX9qs3UzT0gDmgQWEuqHgIipsjqilfow+0dL0/VTO3W/O+r3TUGcI1xg8XVidvc/YOv5mG5SLmjwSh17ZBwHsxI1VOgezm0rKm/Oy0qJoMr/PZoAwj9K8jC5SM2lHk7tHVJoRDW9hEEFlSwTsvkNV3fC2DLVn/7eTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769214844; c=relaxed/simple;
	bh=0puhnsE9POTfVsc5x7ltQ8PV85YNfgHWUtJIUI/oVFo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tnX6eJIgl3uieJfb+kpsYlsqaUcV2Jm9MS6Sw5JTv73h1HsKHLi54ev9VLffRfGcBwdxu0LfuWizMIkN0Eyo0ma8Eea0q+ADeaC1rHTfNIYUFwrVtH1HG24z+cAbZN0WOHkgsfY67QFHncZ2CoHa+gHT/5U28TDOfBhIGS51Pso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/VepZ6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CBBC4CEF1;
	Sat, 24 Jan 2026 00:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769214844;
	bh=0puhnsE9POTfVsc5x7ltQ8PV85YNfgHWUtJIUI/oVFo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=m/VepZ6SP+Qk3o/9hiNY7d0RXZAGqW9eRlYNxtLZ6SlOHO3P4egsyk2eAsHByjZoK
	 vjmlypYn+OzwcnrhF0IN9o6AUh8mbpDp1NRJi96RUGC1l9ILQahULD0AL6cGfKOA4t
	 HAKO84B1onRPsPlFSMmYmz8xNu/2uwuXQWyVn7Nc0nAD+WrEaYEkMJuFVwjogPZBHU
	 024pcyLCs2+hdy+9KfV09YXtLR346C3/oCQrRyXGru0dwEdN91vaJD6OLYWJtpLONe
	 XyUoFdq5isTdCrCD86W5eLTN+LmFrK+ekxVmiwP0tT/xTFRDSoGihTDzBR8OHIDdIe
	 Awqn1YmNBBamQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 077ECF4006A;
	Fri, 23 Jan 2026 19:34:03 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 23 Jan 2026 19:34:03 -0500
X-ME-Sender: <xms:ehN0aam3LS7xIJ6-aUnTxv81UM84ZRIKuSAiNr7brekEUq9Oc1p6ZA>
    <xme:ehN0acrc03UFj4Txne2BVPTr9BiLxIAI0io3WJAvRslEU0uEc-YXos5rN3SHYW9WB
    ZQzpKCv1E17_9c9Cdy8on3UmlUh-dsxbOw4EqiLEg-6i6pr_TbrBp4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduhedtgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeegheduieeiveevheelheelueeghffhtddtheelhfdutddtheeileetkeelvedtjeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    peduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvihhlsegsrhhofihnrd
    hnrghmvgdprhgtphhtthhopehrihgtkhdrmhgrtghklhgvmhesghhmrghilhdrtghomhdp
    rhgtphhtthhopegstghougguihhngheshhgrmhhmvghrshhprggtvgdrtghomhdprhgtph
    htthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggsihhgghgvrhhs
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihhnuh
    igqdgtrhihphhtohesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ehN0aXvatQ13EJeQ1hh_jNcWV_JkTuIAOa93HP4DdEx-6bBrSmFkIA>
    <xmx:ehN0aUTzTQn0SNr5ogjUewbOG-syY0pv3W8LvkHi083tO9SevrO3NQ>
    <xmx:ehN0aWLlwAFtFQxG_SUOWov3g-vyf-sHdPGihBqVVEnpqjKjoxl-Hw>
    <xmx:ehN0afvzPbLUF9Ty8R5S910jjwtfok1fMJbfSt13tVcgFsWYy6oIqw>
    <xmx:exN0aV_6gmkH4kkqCIIMRfWBr_mmnbRkJ3lXJfUCCh_a9IrWoxYdmQAk>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D7193780070; Fri, 23 Jan 2026 19:34:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvBI4pOdhfek
Date: Fri, 23 Jan 2026 19:33:42 -0500
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>,
 "Rick Macklem" <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Message-Id: <e545c35e-31fc-4069-8d83-1f9585e82532@app.fastmail.com>
In-Reply-To: <176921153233.16766.17284825218875728993@noble.neil.brown.name>
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <=?utf-8?q?=3C0a?==?utf-8?q?aa9ca4fd3edc7e0d25433ad472cb873560bf7d=2E1769026777=2Egit=2Ebcodd?==?utf-8?q?ing=40hammerspace=2Ecom=3E=2C?=<5fb38378-a8e0-46d5-956c-de1a3bdaaf23@app.fastmail.com>,<176920688733.16766.188886135069880896@noble.neil.brown.name>,<8d024335-7be0-48f3-80d3-99bd85b6386b@kernel.org>>
 <176921153233.16766.17284825218875728993@noble.neil.brown.name>
Subject: Re: [PATCH v2 3/3] NFSD: Sign filehandles
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_CC(0.00)[hammerspace.com,oracle.com,kernel.org,gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75332-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B84927BB18
X-Rspamd-Action: no action



On Fri, Jan 23, 2026, at 6:38 PM, NeilBrown wrote:
> On Sat, 24 Jan 2026, Chuck Lever wrote:
>> On 1/23/26 5:21 PM, NeilBrown wrote:
>> > On Sat, 24 Jan 2026, Chuck Lever wrote:
>> >>
>> >> On Wed, Jan 21, 2026, at 3:24 PM, Benjamin Coddington wrote:
>> >>> NFS clients may bypass restrictive directory permissions by using
>> >>> open_by_handle() (or other available OS system call) to guess the
>> >>> filehandles for files below that directory.
>> >>>
>> >>> In order to harden knfsd servers against this attack, create a me=
thod to
>> >>> sign and verify filehandles using siphash as a MAC (Message Authe=
ntication
>> >>> Code).  Filehandles that have been signed cannot be tampered with=
, nor can
>> >>> clients reasonably guess correct filehandles and hashes that may =
exist in
>> >>> parts of the filesystem they cannot access due to directory permi=
ssions.
>> >>>
>> >>> Append the 8 byte siphash to encoded filehandles for exports that=
 have set
>> >>> the "sign_fh" export option.  The filehandle's fh_auth_type is se=
t to
>> >>> FH_AT_MAC(1) to indicate the filehandle is signed.  Filehandles r=
eceived from
>> >>> clients are verified by comparing the appended hash to the expect=
ed hash.
>> >>> If the MAC does not match the server responds with NFS error _BAD=
HANDLE.
>> >>> If unsigned filehandles are received for an export with "sign_fh"=
 they are
>> >>> rejected with NFS error _BADHANDLE.
>> >>>
>> >>> Link:=20
>> >>> https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@h=
ammerspace.com
>> >>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>> >>> ---
>> >>>  fs/nfsd/nfsfh.c | 73 +++++++++++++++++++++++++++++++++++++++++++=
++++--
>> >>>  fs/nfsd/nfsfh.h |  3 ++
>> >>>  2 files changed, 73 insertions(+), 3 deletions(-)
>> >>>
>> >>> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
>> >>> index ed85dd43da18..ea3473acbf71 100644
>> >>> --- a/fs/nfsd/nfsfh.c
>> >>> +++ b/fs/nfsd/nfsfh.c
>> >>> @@ -11,6 +11,7 @@
>> >>>  #include <linux/exportfs.h>
>> >>>
>> >>>  #include <linux/sunrpc/svcauth_gss.h>
>> >>> +#include <crypto/utils.h>
>> >>>  #include "nfsd.h"
>> >>>  #include "vfs.h"
>> >>>  #include "auth.h"
>> >>> @@ -137,6 +138,61 @@ static inline __be32 check_pseudo_root(struc=
t=20
>> >>> dentry *dentry,
>> >>>  	return nfs_ok;
>> >>>  }
>> >>>
>> >>> +/*
>> >>> + * Append an 8-byte MAC to the filehandle hashed from the server=
's=20
>> >>> fh_key:
>> >>> + */
>> >>> +static int fh_append_mac(struct svc_fh *fhp, struct net *net)
>> >>> +{
>> >>> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>> >>> +	struct knfsd_fh *fh =3D &fhp->fh_handle;
>> >>> +	siphash_key_t *fh_key =3D nn->fh_key;
>> >>> +	u64 hash;
>> >>> +
>> >>> +	if (!(fhp->fh_export->ex_flags & NFSEXP_SIGN_FH))
>> >>> +		return 0;
>> >>> +
>> >>> +	if (!fh_key) {
>> >>> +		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_key =
not=20
>> >>> set.\n");
>> >>> +		return -EINVAL;
>> >>> +	}
>> >>> +
>> >>> +	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize) {
>> >>> +		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size=
 %d=20
>> >>> would be greater"
>> >>> +			" than fh_maxsize %d.\n", (int)(fh->fh_size + sizeof(hash)),=20
>> >>> fhp->fh_maxsize);
>> >>> +		return -EINVAL;
>> >>> +	}
>> >>> +
>> >>> +	fh->fh_auth_type =3D FH_AT_MAC;
>> >>> +	hash =3D siphash(&fh->fh_raw, fh->fh_size, fh_key);
>> >>> +	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
>> >>> +	fh->fh_size +=3D sizeof(hash);
>> >>> +
>> >>> +	return 0;
>> >>> +}
>> >>> +
>> >>> +/*
>> >>> + * Verify that the the filehandle's MAC was hashed from this fil=
ehandle
>> >>> + * given the server's fh_key:
>> >>> + */
>> >>> +static int fh_verify_mac(struct svc_fh *fhp, struct net *net)
>> >>> +{
>> >>> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>> >>> +	struct knfsd_fh *fh =3D &fhp->fh_handle;
>> >>> +	siphash_key_t *fh_key =3D nn->fh_key;
>> >>> +	u64 hash;
>> >>> +
>> >>> +	if (fhp->fh_handle.fh_auth_type !=3D FH_AT_MAC)
>> >>> +		return -EINVAL;
>> >>> +
>> >>> +	if (!fh_key) {
>> >>> +		pr_warn_ratelimited("NFSD: unable to verify signed filehandles=
,=20
>> >>> fh_key not set.\n");
>> >>> +		return -EINVAL;
>> >>> +	}
>> >>> +
>> >>> +	hash =3D siphash(&fh->fh_raw, fh->fh_size - sizeof(hash),  fh_k=
ey);
>> >>> +	return crypto_memneq(&fh->fh_raw[fh->fh_size - sizeof(hash)], &=
hash,=20
>> >>> sizeof(hash));
>> >>> +}
>> >>> +
>> >>>  /*
>> >>>   * Use the given filehandle to look up the corresponding export =
and
>> >>>   * dentry.  On success, the results are used to set fh_export and
>> >>> @@ -166,8 +222,11 @@ static __be32 nfsd_set_fh_dentry(struct svc_=
rqst=20
>> >>> *rqstp, struct net *net,
>> >>>
>> >>>  	if (--data_left < 0)
>> >>>  		return error;
>> >>> -	if (fh->fh_auth_type !=3D 0)
>> >>> +
>> >>> +	/* either FH_AT_NONE or FH_AT_MAC */
>> >>> +	if (fh->fh_auth_type > 1)
>> >>>  		return error;
>> >>> +
>> >>>  	len =3D key_len(fh->fh_fsid_type) / 4;
>> >>>  	if (len =3D=3D 0)
>> >>>  		return error;
>> >>> @@ -237,9 +296,14 @@ static __be32 nfsd_set_fh_dentry(struct svc_=
rqst=20
>> >>> *rqstp, struct net *net,
>> >>>
>> >>>  	fileid_type =3D fh->fh_fileid_type;
>> >>>
>> >>> -	if (fileid_type =3D=3D FILEID_ROOT)
>> >>> +	if (fileid_type =3D=3D FILEID_ROOT) {
>> >>>  		dentry =3D dget(exp->ex_path.dentry);
>> >>> -	else {
>> >>> +	} else {
>> >>> +		if (exp->ex_flags & NFSEXP_SIGN_FH && fh_verify_mac(fhp, net))=
 {
>> >>> +			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp, -EKEYREJECTED);
>> >>> +			goto out;
>> >>> +		}
>> >>> +
>> >>>  		dentry =3D exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
>> >>>  						data_left, fileid_type, 0,
>> >>>  						nfsd_acceptable, exp);
>> >>> @@ -495,6 +559,9 @@ static void _fh_update(struct svc_fh *fhp, st=
ruct=20
>> >>> svc_export *exp,
>> >>>  		fhp->fh_handle.fh_fileid_type =3D
>> >>>  			fileid_type > 0 ? fileid_type : FILEID_INVALID;
>> >>>  		fhp->fh_handle.fh_size +=3D maxsize * 4;
>> >>> +
>> >>> +		if (fh_append_mac(fhp, exp->cd->net))
>> >>> +			fhp->fh_handle.fh_fileid_type =3D FILEID_INVALID;
>> >>>  	} else {
>> >>>  		fhp->fh_handle.fh_fileid_type =3D FILEID_ROOT;
>> >>>  	}
>> >>> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
>> >>> index 5ef7191f8ad8..7fff46ac2ba8 100644
>> >>> --- a/fs/nfsd/nfsfh.h
>> >>> +++ b/fs/nfsd/nfsfh.h
>> >>> @@ -59,6 +59,9 @@ struct knfsd_fh {
>> >>>  #define fh_fsid_type		fh_raw[2]
>> >>>  #define fh_fileid_type		fh_raw[3]
>> >>>
>> >>> +#define FH_AT_NONE		0
>> >>> +#define FH_AT_MAC		1
>> >>
>> >> I'm pleased at how much this patch has shrunk since v1.
>> >>
>> >> This might not be an actionable review comment, but help me unders=
tand
>> >> this particular point. Why do you need both a sign_fh export option
>> >> and a new FH auth type? Shouldn't the server just look for and
>> >> validate FH signatures whenever the sign_fh export option is
>> >> present?
>> >=20
>> > ...and also generate valid signatures on outgoing file handles.
>> >=20
>> > What does the server do to "look for" an FH signature so that it can
>> > "validate" it?  Answer: it inspects the fh_auth_type to see if it is
>> > FT_AT_MAC.=20
>>=20
>> No, NFSD checks the sign_fh export option. At first glance the two
>> seem redundant, and I might hesitate to inspect or not inspect
>> depending on information content received from a remote system. The
>> security policy is defined precisely by the "sign_fh" export option I
>> would think?
>
> So maybe you are thinking that, when sign_fh, is in effect - nfsd
> could always strip off the last 8 bytes, hash the remainder, and check
> the result matches the stripped bytes.

I=E2=80=99m wondering why there is both =E2=80=94 the purpose of having =
these two
seemingly redundant signals is worth documenting. There was some
discussion a few days ago about whether the root FH could be signed
or not. I thought for a moment or two that maybe when sign_fh is
enabled, there will be one or more file handles on that export that
won=E2=80=99t have a signature, and FT_AT_NONE would set those apart
from the signed FHs. Again, I=E2=80=99d like to see that documented if t=
hat is
the case.

In addition, I=E2=80=99ve always been told that what comes off the netwo=
rk
is completely untrusted. So, I want some assurance that using the
incoming FH=E2=80=99s auth type as part of the decision to check the sig=
nature
conforms with known best practices.

> Another reason is that it helps people who are looking at network
> packets captures to try to work out what is going wrong.
> Seeing a flag to say "there is a signature" could help.

Sure. But unconditionally trusting that flag is another question.


--=20
Chuck Lever

