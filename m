Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51325273F95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 12:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgIVK04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 06:26:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:48544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgIVK04 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:26:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600770414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NMJmnLI06vJXPxa6modAvGqnYZPCj9ff74h1pzwMv/4=;
        b=dgDYvubZbMVTnG9XAG9gizyD0wYkqNHziClRtQHrrL5/1yRtJpQ6gaE+Ir2RbM0mHKRcvB
        JP0QhPuW0SZ4s4l6SVeOsa7WFj32f+KHNx7jlQaC3f8mWgEdtK8ErwPJB49rhMy0hrs4Wy
        E1xw+4IXKArfp+XVS4eR9s52Mh1JYkc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4BD69B226;
        Tue, 22 Sep 2020 10:27:31 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>
Subject: Re: [PATCH v3 04/10] fs/ntfs3: Add file operations and implementation
In-Reply-To: <20200921133647.3tczqm5zfvae6q6a@pali>
References: <20200828143938.102889-1-almaz.alexandrovich@paragon-software.com>
 <20200828143938.102889-5-almaz.alexandrovich@paragon-software.com>
 <20200904115049.i6zjfwba7egalxnp@pali>
 <820d8a637a41448194f60dee4361dea0@paragon-software.com>
 <20200921133647.3tczqm5zfvae6q6a@pali>
Date:   Tue, 22 Sep 2020 12:26:53 +0200
Message-ID: <877dsmksya.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:
> I think ENAMETOOLONG could be useful also for other filesystem drivers.
>
> So for me it looks better to extend kernel's utf8s_to_utf16s() function
> and use it in ntfs driver instead of having private (modified/duplicate)
> copy of utf8s_to_utf16s() in ntfs driver.

As a side note, cifs has related functions that may be useful.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/=
cifs/cifs_unicode.c

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, DE
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)
