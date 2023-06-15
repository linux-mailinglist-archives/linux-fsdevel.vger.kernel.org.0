Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7048C73210E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 22:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjFOUmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 16:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFOUmU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:42:20 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A3826AA;
        Thu, 15 Jun 2023 13:42:18 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 61BF51C0E67; Thu, 15 Jun 2023 22:42:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1686861736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Swml0mtxVfq+msbs6Sx0sxLLdwoWY72Og0WE8BEL9WM=;
        b=lwN+AAnArNFRsZTpgnBd8mnMp2SIPUFZ28picwxTn4reJ5f6IQgsLRJtIiLidXu13zqwdc
        U5LtkF6x2MmXu7xatLZRuknEOSXEheff6IjIUMZ9d7WO092AFyb4Qqexle9/NRjLal0dNW
        N/w2Rg3+LxsepWHJ2JN0ZBKq2CyluxU=
Date:   Thu, 15 Jun 2023 22:41:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-bcachefs@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, boqun.feng@gmail.com,
        brauner@kernel.org, hch@infradead.org, colyli@suse.de,
        djwong@kernel.org, mingo@redhat.com, jack@suse.cz, axboe@kernel.dk,
        willy@infradead.org, ojeda@kernel.org, ming.lei@redhat.com,
        ndesaulniers@google.com, peterz@infradead.org,
        phillip@squashfs.org.uk, urezki@gmail.com, longman@redhat.com,
        will@kernel.org
Subject: Re: [PATCH 00/32] bcachefs - a new COW filesystem
Message-ID: <20230615204156.GA1119@bug>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230509165657.1735798-1-kent.overstreet@linux.dev>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

> I'm submitting the bcachefs filesystem for review and inclusion.
>=20
> Included in this patch series are all the non fs/bcachefs/ patches. The
> entire tree, based on v6.3, may be found at:
>=20
>   http://evilpiepirate.org/git/bcachefs.git bcachefs-for-upstream
>=20
> ----------------------------------------------------------------
>=20
> bcachefs overview, status:
>=20
> Features:
>  - too many to list
>=20
> Known bugs:
>  - too many to list


Documentation: missing.

Dunno. I guess it would help review if feature and known bugs lists were in=
cluded.

BR,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
