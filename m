Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD404E7061
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 11:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358589AbiCYKAY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 06:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiCYKAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:00:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035666E2A8;
        Fri, 25 Mar 2022 02:58:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B534E1F745;
        Fri, 25 Mar 2022 09:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648202328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qE3ijpN3JzxZRinNK3bY7itv2EzK7o8jpCboIZgMOrk=;
        b=PiSKKvvvD9ORMpFiph9LNgdYzV+1b+SMiJWH8a4ZrvzPNMxCx+92w8//Nwh5pnbfJSh/s2
        ttAfN+KbiBcZmf3T1nmmoILzLPFl20o/tSjESDUKWqqPaMEBHNwwPMNRp4xNsvAxobKpJd
        P/paw+0XfHloh17+LRUhgob+mmXd3IE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648202328;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qE3ijpN3JzxZRinNK3bY7itv2EzK7o8jpCboIZgMOrk=;
        b=iO2SonJglDeQTgQPlWaycm3HefPzlzqXev9YSaQnny+TqDUSe2ZKnyqRkDOEJltuDNFcsq
        8xCLxwlSnQUZzrAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38053132E9;
        Fri, 25 Mar 2022 09:58:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wW3qCliSPWIHDwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 25 Mar 2022 09:58:48 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 4fb5c2e5;
        Fri, 25 Mar 2022 09:59:08 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com,
        xiubli@redhat.com, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v11 02/51] fscrypt: export fscrypt_base64url_encode
 and fscrypt_base64url_decode
References: <20220322141316.41325-1-jlayton@kernel.org>
        <20220322141316.41325-3-jlayton@kernel.org>
        <87zglgoi1e.fsf@brahms.olymp> <YjyubQgfbQbUn4Ct@gmail.com>
Date:   Fri, 25 Mar 2022 09:59:08 +0000
In-Reply-To: <YjyubQgfbQbUn4Ct@gmail.com> (Eric Biggers's message of "Thu, 24
        Mar 2022 17:46:21 +0000")
Message-ID: <87sfr6nyj7.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Wed, Mar 23, 2022 at 02:33:17PM +0000, Lu=C3=ADs Henriques wrote:
>> Hi Eric,
>>=20
>> Jeff Layton <jlayton@kernel.org> writes:
>>=20
>> > Ceph is going to add fscrypt support, but we still want encrypted
>> > filenames to be composed of printable characters, so we can maintain
>> > compatibility with clients that don't support fscrypt.
>> >
>> > We could just adopt fscrypt's current nokey name format, but that is
>> > subject to change in the future, and it also contains dirhash fields
>> > that we don't need for cephfs. Because of this, we're going to concoct
>> > our own scheme for encoding encrypted filenames. It's very similar to
>> > fscrypt's current scheme, but doesn't bother with the dirhash fields.
>> >
>> > The ceph encoding scheme will use base64 encoding as well, and we also
>> > want it to avoid characters that are illegal in filenames. Export the
>> > fscrypt base64 encoding/decoding routines so we can use them in ceph's
>> > fscrypt implementation.
>> >
>> > Acked-by: Eric Biggers <ebiggers@google.com>
>> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> > ---
>> >  fs/crypto/fname.c       | 8 ++++----
>> >  include/linux/fscrypt.h | 5 +++++
>> >  2 files changed, 9 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
>> > index a9be4bc74a94..1e4233c95005 100644
>> > --- a/fs/crypto/fname.c
>> > +++ b/fs/crypto/fname.c
>> > @@ -182,8 +182,6 @@ static int fname_decrypt(const struct inode *inode,
>> >  static const char base64url_table[65] =3D
>> >  	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
>> >=20=20
>> > -#define FSCRYPT_BASE64URL_CHARS(nbytes)	DIV_ROUND_UP((nbytes) * 4, 3)
>> > -
>> >  /**
>> >   * fscrypt_base64url_encode() - base64url-encode some binary data
>> >   * @src: the binary data to encode
>> > @@ -198,7 +196,7 @@ static const char base64url_table[65] =3D
>> >   * Return: the length of the resulting base64url-encoded string in by=
tes.
>> >   *	   This will be equal to FSCRYPT_BASE64URL_CHARS(srclen).
>> >   */
>> > -static int fscrypt_base64url_encode(const u8 *src, int srclen, char *=
dst)
>> > +int fscrypt_base64url_encode(const u8 *src, int srclen, char *dst)
>>=20
>> I know you've ACK'ed this patch already, but I was wondering if you'd be
>> open to change these encode/decode interfaces so that they could be used
>> for non-url base64 too.
>>=20
>> My motivation is that ceph has this odd limitation where snapshot names
>> can not start with the '_' character.  And I've an RFC that adds snapshot
>> names encryption support which, unfortunately, can end up starting with
>> this char after base64 encoding.
>>=20
>> So, my current proposal is to use a different encoding table.  I was
>> thinking about the IMAP mailboxes naming which uses '+' and ',' instead =
of
>> the '-' and '_', but any other charset would be OK (except those that
>> include '/' of course).  So, instead of adding yet another base64
>> implementation to the kernel, I was wondering if you'd be OK accepting a
>> patch to add an optional arg to these encoding/decoding functions to pass
>> an alternative table.  Or, if you'd prefer, keep the existing interface
>> but turning these functions into wrappers to more generic functions.
>>=20
>> Obviously, Jeff, please feel free to comment too if you have any reserves
>> regarding this approach.
>>=20
>> Cheers,
>> --=20
>> Lu=C3=ADs
>>=20
>
> Base64 encoding/decoding is trivial enough that I think you should just a=
dd your
> own functions to fs/ceph/ for now if you need yet another Base64 variant.=
  If we
> were to add general functions that allow "building your own" Base64 varia=
nt, I
> think they'd belong in lib/, not fs/crypto/.  (I objected to lib/ in the =
first
> version of Jeff's patchset because that patchset proposed adding just the=
 old,
> idiosyncratic fscrypt Base64 variant to lib/ and just calling it "base64"=
, which
> was misleading.  But, if there were to be properly documented functions to
> "build your own" Base64 variant, allowing control over both the character=
 set
> and whether padding is done, lib/ would be the place...)

OK, that makes sense.  I agree that the right place for a generic
implementation would be somewhere out of the fs/crypto/ directory.  I
guess that, for now, I'll follow your advice and keep a local
implementation (in fact, the libceph *has* already an implementation!).

But adding a generic implementation and clean-up all the different
implementations in the kernel tree is probably a nice project.  For the
future.  Maybe.  *sigh*

Cheers,
--=20
Lu=C3=ADs
