Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3AB9A6CC9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 17:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbfICPU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 11:20:57 -0400
Received: from sonic311-22.consmr.mail.bf2.yahoo.com ([74.6.131.196]:33756
        "EHLO sonic311-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729537AbfICPUy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567524052; bh=TMtiGR6eRY4JXVQE6K2FOJLCSh0SN/dUnRdFJ4kOeVo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=hmAa8yTgiOPbZrVPgL9JwC1XL0sxZm7aAOmTe0qLday0oV9rzjFHHJZH5ow68g17xI9eWDJ/aXpwH3zMCKWRhoUW4IsBUTqC28r9TrLDmLDbx16PpFhRSFPreRBc53VAGbcwOMSPcmcQqnluOnuLfFEdFCy5iloo6WHWWRkh+H41LVp2bDqVuscV9QwQFC7Pe4SQCHt7kFaGMCydDVQS9XGvdH4kDjC2YwCjkq3GzLkilJodRvKdvF53Y7XfNTZu9XnbKstD7wk7xGBXJ1sVfpC6pzUmlfctiKvKlLYGVinFIAZOAQHyZxk9u1gYdT3ZyqINj1xHW2h4wA78LDt7Sg==
X-YMail-OSG: Ga9GgFAVM1mOyefZobTWD0KwaHVmaeIZcH1YDkBkmdPYCP6TbWAQtP_y41YcNYr
 EVgP7RSplZbgovcHLHFMBn0rUodYKeqLFmzy88izTYToMfSonqsYp.2Wy2STh9tOeRgi_Te7xTwH
 slGV.5sIPD6s7cBnrnLc4BI.AQw0y4ZEX3tYrKgUZdl0SevAbhHNFYYldQl3QcjrvvbK9b8oOzpQ
 gWm0Cr0cWEIc4RVE97P_CcV_lmSL5X1evatsNByrKcRNogvM8bFBQClXNlJUQKCQTvL5tdy.6MnH
 zrizCTGm4.Q8p1OWerCtwu0sYixmDmU6w_D3ROMOnQTnS8zGoXOkSuX72rwBjlsVQw7HvquYbjAu
 ny83hN.eroFTZg.TwcOxiFIdM4qZPfTMB_kfaCpxPMGDhyMtC0akhmxzTdzl8OL6S_uklm_2dwXY
 6KJhis7KxmC8.iXSnRyKpOtHSPhSMGAuOrg7Yp7SKrw_zwj24SGzWr._B_1ZWu6GLvx9DK5Qrix0
 ISQjyJOwz_n7IH2vZiuAO7SjDzT7XyYrr_E04pcoWgZn3QTpbRGnI8cDPgDaLc9R13T7JH.Ie1Xx
 NR45.u8QthEZ2j6r8Zdtj2QiYxk86M2O5SeNvCHdewytUc81i2Jl2WYrWk2nYl9l2.gbUxpyStYU
 h9rWjynkHQqJNySlEv3Qn.M0wgBFhl7_jU0rQ6YSA38iDRwlq7QOQqzald2EaDFft_rTuGcxryTV
 4ck_UCfG1GIXglAf8oomVpYVmXMZDuX0Vvcx4xfex7blwn2F_6oT4AHJfUeK5SxObKHhadAEYPNy
 bazW.nFZBum5TgB40qFwW4r0pSdCKQIWyCPvm7xecw1v.qS7yhhPpKluyq7mTu1jgnPPMiFd6dES
 iL0pPdjhyNUit56plUfd5_o0n4tB2jEHrQcrUSw44k5aq6D.MJxo2n_YOr6Y1Al8jU2Dcfd4Nsvk
 6jpjDj0p15ArKg7OL08_TNkPc8x3icb0RiM4XvvSqwhKkpysi9PE0mKHMQg18ntd4EosWN9DXzro
 imN9jTjWyJZ3v2U7NEBCrdxPtzhJCDPYd6FfZfTR2rcJqAs2IuNQjvwSQVBtsaxb35mVmbS9xn37
 Us8NfZLKvoXhLLrsrhDQJVSke_SCxkO8IW72DNl.w4_ithkCKJGk5.xMJoHl0ujcAYve0F7MK2TL
 M_u0K4W8QMk56aPCeNdB1AEzuMWtk2TVL3glEA8dngC53gWpLl3foLa4J8yUFVZ0Q_8_HL3MurK6
 ryrHGo7kqVfELnDyRs5MvKmG5vYOgOtqISUITzsT.HFSuJIN.
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Tue, 3 Sep 2019 15:20:52 +0000
Received: by smtp403.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 37155d70885c019b8dadd518967841e9;
          Tue, 03 Sep 2019 15:20:49 +0000 (UTC)
Subject: Re: [PATCH 11/11] smack: Implement the watch_key and
 post_notification hooks [untested] [ver #7]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        casey@schaufler-ca.com
References: <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk>
 <156717352917.2204.17206219813087348132.stgit@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <e36fa722-a300-2abf-ae9c-a0246fc66d0e@schaufler-ca.com>
Date:   Tue, 3 Sep 2019 08:20:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156717352917.2204.17206219813087348132.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/30/2019 6:58 AM, David Howells wrote:
> Implement the watch_key security hook in Smack to make sure that a key
> grants the caller Read permission in order to set a watch on a key.
>
> Also implement the post_notification security hook to make sure that th=
e
> notification source is granted Write permission by the watch queue.
>
> For the moment, the watch_devices security hook is left unimplemented a=
s
> it's not obvious what the object should be since the queue is global an=
d
> didn't previously exist.
>
> Signed-off-by: David Howells <dhowells@redhat.com>

I tried running your key tests and they fail in "keyctl/move/valid",
with 11 FAILED messages, finally hanging after "UNLINK KEY FROM SESSION".=

It's possible that my Fedora26 system is somehow incompatible with the
tests. I don't see anything in your code that would cause this, as the
Smack policy on the system shouldn't restrict any access.

> ---
>
>  include/linux/lsm_audit.h  |    1 +
>  security/smack/smack_lsm.c |   82 ++++++++++++++++++++++++++++++++++++=
+++++++-
>  2 files changed, 82 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> index 915330abf6e5..734d67889826 100644
> --- a/include/linux/lsm_audit.h
> +++ b/include/linux/lsm_audit.h
> @@ -74,6 +74,7 @@ struct common_audit_data {
>  #define LSM_AUDIT_DATA_FILE	12
>  #define LSM_AUDIT_DATA_IBPKEY	13
>  #define LSM_AUDIT_DATA_IBENDPORT 14
> +#define LSM_AUDIT_DATA_NOTIFICATION 15
>  	union 	{
>  		struct path path;
>  		struct dentry *dentry;
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 4c5e5a438f8b..1c2a908c6446 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4274,7 +4274,7 @@ static int smack_key_permission(key_ref_t key_ref=
,
>  	if (tkp =3D=3D NULL)
>  		return -EACCES;
> =20
> -	if (smack_privileged_cred(CAP_MAC_OVERRIDE, cred))
> +	if (smack_privileged(CAP_MAC_OVERRIDE))
>  		return 0;
> =20
>  #ifdef CONFIG_AUDIT
> @@ -4320,8 +4320,81 @@ static int smack_key_getsecurity(struct key *key=
, char **_buffer)
>  	return length;
>  }
> =20
> +
> +#ifdef CONFIG_KEY_NOTIFICATIONS
> +/**
> + * smack_watch_key - Smack access to watch a key for notifications.
> + * @key: The key to be watched
> + *
> + * Return 0 if the @watch->cred has permission to read from the key ob=
ject and
> + * an error otherwise.
> + */
> +static int smack_watch_key(struct key *key)
> +{
> +	struct smk_audit_info ad;
> +	struct smack_known *tkp =3D smk_of_current();
> +	int rc;
> +
> +	if (key =3D=3D NULL)
> +		return -EINVAL;
> +	/*
> +	 * If the key hasn't been initialized give it access so that
> +	 * it may do so.
> +	 */
> +	if (key->security =3D=3D NULL)
> +		return 0;
> +	/*
> +	 * This should not occur
> +	 */
> +	if (tkp =3D=3D NULL)
> +		return -EACCES;
> +
> +	if (smack_privileged_cred(CAP_MAC_OVERRIDE, current_cred()))
> +		return 0;
> +
> +#ifdef CONFIG_AUDIT
> +	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_KEY);
> +	ad.a.u.key_struct.key =3D key->serial;
> +	ad.a.u.key_struct.key_desc =3D key->description;
> +#endif
> +	rc =3D smk_access(tkp, key->security, MAY_READ, &ad);
> +	rc =3D smk_bu_note("key watch", tkp, key->security, MAY_READ, rc);
> +	return rc;
> +}
> +#endif /* CONFIG_KEY_NOTIFICATIONS */
>  #endif /* CONFIG_KEYS */
> =20
> +#ifdef CONFIG_WATCH_QUEUE
> +/**
> + * smack_post_notification - Smack access to post a notification to a =
queue
> + * @w_cred: The credentials of the watcher.
> + * @cred: The credentials of the event source (may be NULL).
> + * @n: The notification message to be posted.
> + */
> +static int smack_post_notification(const struct cred *w_cred,
> +				   const struct cred *cred,
> +				   struct watch_notification *n)
> +{
> +	struct smk_audit_info ad;
> +	struct smack_known *subj, *obj;
> +	int rc;
> +
> +	/* Always let maintenance notifications through. */
> +	if (n->type =3D=3D WATCH_TYPE_META)
> +		return 0;
> +
> +	if (!cred)
> +		return 0;
> +	subj =3D smk_of_task(smack_cred(cred));
> +	obj =3D smk_of_task(smack_cred(w_cred));
> +
> +	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_NOTIFICATION);
> +	rc =3D smk_access(subj, obj, MAY_WRITE, &ad);
> +	rc =3D smk_bu_note("notification", subj, obj, MAY_WRITE, rc);
> +	return rc;
> +}
> +#endif /* CONFIG_WATCH_QUEUE */
> +
>  /*
>   * Smack Audit hooks
>   *
> @@ -4710,8 +4783,15 @@ static struct security_hook_list smack_hooks[] _=
_lsm_ro_after_init =3D {
>  	LSM_HOOK_INIT(key_free, smack_key_free),
>  	LSM_HOOK_INIT(key_permission, smack_key_permission),
>  	LSM_HOOK_INIT(key_getsecurity, smack_key_getsecurity),
> +#ifdef CONFIG_KEY_NOTIFICATIONS
> +	LSM_HOOK_INIT(watch_key, smack_watch_key),
> +#endif
>  #endif /* CONFIG_KEYS */
> =20
> +#ifdef CONFIG_WATCH_QUEUE
> +	LSM_HOOK_INIT(post_notification, smack_post_notification),
> +#endif
> +
>   /* Audit hooks */
>  #ifdef CONFIG_AUDIT
>  	LSM_HOOK_INIT(audit_rule_init, smack_audit_rule_init),
>

