Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2096E57D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 05:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjDRDZc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 23:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjDRDZ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 23:25:29 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCB6212F
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 20:25:25 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a667067275so13213415ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 20:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1681788325; x=1684380325;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dc+z8UcT8gLBd7VEIREz6So3ovN0gIJ35zlOxamT89Q=;
        b=3274Yui6rH0Nmf2GNT2U3kKf+v46ad2HN7CSmKxrgcHbVsZjIN2Q0QfJ0MrboMgcsB
         cXpJK+AMfpuUXzBpsB6OQuZ2kypvD5kKuF/65nyfVt7qZuD/fEB2wagnEE5696Fxlf5M
         n4nQwYppxsFhl6/oPzSttqtdY/6Kn5R+p03rWJq+4AlSlrh3kbRa00Gd+s4tCNUZJPtq
         J2bzbOfVx9TOeOp7dpXV5yXY5MHV15Y+qQ0pc+QZtxUlDdJhuXtS8K+Yd8EYy8CrAP+K
         dANfGVkUWYB0yLp0uaTfUSA/1OGCi5Px66c+U4lVDrsNdxseaeY4u5refNQy2Kn7g6Bl
         qTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681788325; x=1684380325;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dc+z8UcT8gLBd7VEIREz6So3ovN0gIJ35zlOxamT89Q=;
        b=ka/N0bYsS4gebetqO8ZLZgWZX/rYQv0MxPJNRkrDfl/d5O8wb8HrhXgC7UjTHprM50
         TU+JxyA7DB7aQtA7Zw+LrV3aDsKU3DCr8rQZS4kuQSafcZ0T9KMGNey//6vGcKwyLqn9
         cukZU5G1WS2fk5vtNi4rEg9zYlvpYgyY2VCQH/UQXrXBDOBFZaWXuc1C497faTT/7KFh
         1rfde8UobgDGqh8dSkXVj8loAyh42RukalC8/1H0ImoWTBloIAR0djSIh8DBxZXj3rDf
         eYIOUTLEfQzdGBcfUXWHe9ye2hIIMdAcM2k0DnNIXypjVo0eGCIeQSIwt+97YQ5g+Gqc
         aJNw==
X-Gm-Message-State: AAQBX9eYYEOHgDdeTuiYgKmSBUghHBcLKi/nP3ho11CVYtRvmkYVKuT/
        54kHyJlX3ZDxse5FKzGtzOcvDg==
X-Google-Smtp-Source: AKy350ZXvC63ci+YEOlpHYFoSVBiObzFZEAeooGgAhHTKgLvqt6Qxfz75tFijyzCUui44AjCfBlB6g==
X-Received: by 2002:a17:903:40cc:b0:1a6:c58e:2d57 with SMTP id t12-20020a17090340cc00b001a6c58e2d57mr655579pld.50.1681788324832;
        Mon, 17 Apr 2023 20:25:24 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902724300b001a217a7a11csm8352037pll.131.2023.04.17.20.25.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2023 20:25:23 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <1AC965F2-BAC6-4D0F-A2A6-C414CDF110AF@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_581956D5-D9DE-48C3-929B-CAF6060706C3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH/RFC] VFS: LOOKUP_MOUNTPOINT should used cached info
 whenever possible.
Date:   Mon, 17 Apr 2023 21:25:20 -0600
In-Reply-To: <85774a5de74b2b7828c8b8f7e041f0e9e2bc6094.camel@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, NeilBrown <neilb@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Karel Zak <kzak@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
 <168168683217.24821.6260957092725278201@noble.neil.brown.name>
 <20230417-beisein-investieren-360fa20fb68a@brauner>
 <6c08ad94ca949d0f3525f7e1fc24a72c50affd59.camel@kernel.org>
 <20230417-relaxen-selektiert-4b4b4143d7f6@brauner>
 <85774a5de74b2b7828c8b8f7e041f0e9e2bc6094.camel@kernel.org>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_581956D5-D9DE-48C3-929B-CAF6060706C3
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> On Apr 17, 2023, at 9:21 AM, Jeff Layton <jlayton@kernel.org> wrote:
> 
> On Mon, 2023-04-17 at 16:24 +0200, Christian Brauner wrote:
>> And I'm curious why is it obvious that we don't want to revalidate _any_
>> path component and not just the last one? Why is that generally safe?
>> Why can't this be used to access files and directories the caller
>> wouldn't otherwise be able to access? I would like to have this spelled
>> out for slow people like me, please.
>> 
>> From my point of view, this would only be somewhat safe _generally_ if
>> you'd allow circumvention for revalidation and permission checking if
>> MNT_FORCE is specified and the caller has capable(CAP_DAC_READ_SEARCH).
>> You'd still mess with overlayfs permission model in this case though.
>> 
>> Plus, there are better options of solving this problem. Again, I'd
>> rather build a separate api for unmounting then playing such potentially
>> subtle security sensitive games with permission checking during path
>> lookup.
> 
> umount(2) is really a special case because the whole intent is to detach
> a mount from the local hierarchy and stop using it. The unfortunate bit
> is that it is a path-based syscall.
> 
> So usually we have to:
> 
> - determine the path: Maybe stat() it and to validate that it's the
>   mountpoint we want to drop

The stat() itself may hang because a remote server, or USB stick is
inaccessible or having media errors.

I've just been having a conversation with Karel Zak to change
umount(1) to use statx() so that it interacts minimally with the fs.

In particular, nfs_getattr() skips revalidate if only minimal attrs
are fetched (STATX_TYPE | STATX_INO), and also skips revalidate if
locally-cached attrs are still valid (STATX_MODE), so this will
avoid yet one more place that unmount can hang.

In theory, vfs_getattr() could get all of these attributes directly
from the vfs_inode in the unmount case.

> - then call umount with that path
> 
> The last thing we want in that case is for the server to decide to
> change some intermediate dentry in between the two operations. Best
> case, you'll get back ENOENT or something when the pathwalk fails. Worst
> case, the server swaps what are two different mountpoints on your client
> and you unmount the wrong one.
> 
> If we don't revaliate, then we're no worse off, and may be better off if
> something hinky happens to the server of an intermediate dentry in the
> path.
> --
> Jeff Layton <jlayton@kernel.org>


Cheers, Andreas






--Apple-Mail=_581956D5-D9DE-48C3-929B-CAF6060706C3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmQ+DaAACgkQcqXauRfM
H+D9bhAArwx6YZ1JWmKrSRDxkjrjKPXa7tALqsqaRKxRH9Ar2aZNhOsQNH/APN9G
+kLPKYXTveRbj2LEvRwkk+O2rpmJ+7u2UFb1/l+gCWnEmlrdS9yQZI4k6cnX/iNW
gD6eXO7172P5ZHkOtQTxlRVt0gAk21h97xAkCF4D/+xgqRnTXUzkpsLmy3082cJH
WHWoXenHnoVMKA1KXZedMS19wvPuoNsJJvVvXNN4K7q28G+PTbKHIamdXuoshW5N
n7EnhCm7CxHpZyLybnrDUWCBDCxWfEv+geBomG/hofsk4IdctfkU0Se92vDtyu9U
LchEF8rP1ckwGEX4Kl5mjePRXRn2eNNIi1Y8XpslmKzljQvdvPerM0NZbIxwz+JJ
HkjBTC/GHBQ1dFUcxJdLb82fF5Lg7H0uqeEOgLgOhxei6C+YcgqnetXMp+VEMInn
ZrqymJhpZWs5WQm3B4aLeA4u5918TBNPknZm1Vk3zl+y2khctkVlF4CE90kkGHC6
fZrPKRk694rFE2l8y5f+tXDPBKsoHYwD6tP9E1bwKNqGatCwXRcX5b3hfqK6Vt0w
znGX0sxxKKKM2drEeqJrIOzb5ztwAFca/FH7tnA1zJnxuq4GCeY6dkmKjqDjgVGe
kT6dcKfsHNHj58FCFmT/yI/LFQJ+rVhqQTMV0uIhh0QmKqHVgEo=
=bL3W
-----END PGP SIGNATURE-----

--Apple-Mail=_581956D5-D9DE-48C3-929B-CAF6060706C3--
