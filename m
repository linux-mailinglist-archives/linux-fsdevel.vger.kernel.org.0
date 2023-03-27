Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC38B6CA11B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 12:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjC0KUc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 06:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjC0KU2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:20:28 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955284C0F;
        Mon, 27 Mar 2023 03:20:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so1542499wms.5;
        Mon, 27 Mar 2023 03:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679912425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVN4bA3aMNTKiMhToGO/PROcH1X2ZJW5cID3K62e6GM=;
        b=a4fDsZTwGNNI91uKTkqzjm+dkquVOWwnodNN7eiOn76lmDnJkT7YfvYfW0J271gkiQ
         6wWbLEl9gP++PdhBVVWn4vOp3nHvQCOFbC0GCMy4skKcJzugaPPcSaUrLvpwfMYIlW5B
         YBaUiiMl0Ljyp/CNS0I4KB2OkeeXs7gm8HBxyjij4Otj9R7PzOHb25AWeqxRQMqFdTrW
         xVR3Kr7NbIB81qUIJG7pwB9X2nYFkWjlYDUnboueecvTUxT3IR4zCLA7R51yIk0Qj0QY
         bue4JPDm9lzu7N1xgcxiii3tyuV4lGHlVjasuFOqCc//Y3IY4PS0Egv5lZ6DyjJunkXu
         crnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679912425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVN4bA3aMNTKiMhToGO/PROcH1X2ZJW5cID3K62e6GM=;
        b=aai3E8QN5J29SdWvP52m0D1Wgf3wV4JqyThpgpGfWy7HkWZohpYVKBB/EM7RezMw7D
         jUxjZQ/TNLI+3t5zpLy/fwCQdmRqmf5Mv2NOm1ZMhyml9fvDvKXtqA8a3+KkBmX8xX2v
         iAvjJMinfGTXoH0BChdQvl03i/QWjUkQkBN5aEzA8WFbvKGss/q9QbwpYkL5sl2gguM/
         9uS3osXOJXImRBPVOdD/QAor8g/2lOOHWBhkp+R3GCxMrjDLTu7upHvZpm6d7Snv/mtE
         vOagXKFCNZiXSb8Rep1n35D9Lj+VT04AtlYT6+y2xLeZkOy7E5fQDHZECoXLZ/EE72nL
         qNHA==
X-Gm-Message-State: AAQBX9erCYsYFLj0GIJdwhiR5a3p09SDvRRRSymvL91eCVWxYneVksOF
        m10jK9WjvrA/jtvjsGoGK2I=
X-Google-Smtp-Source: AKy350bQs7h8xcV9TLEaRh7IH0YWMQ3rbMxAMmlsx9SInDtkuyNK9/Z8KgJP1hVh7ALS06wFopyFrg==
X-Received: by 2002:a1c:f216:0:b0:3ef:5e17:1ed9 with SMTP id s22-20020a1cf216000000b003ef5e171ed9mr6667246wmc.31.1679912424956;
        Mon, 27 Mar 2023 03:20:24 -0700 (PDT)
Received: from suse.localnet (host-87-19-99-235.retail.telecomitalia.it. [87.19.99.235])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b003ef6bc71cccsm4401373wmq.27.2023.03.27.03.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 03:20:24 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ira.weiny@intel.com
Subject: Re: [git pull] common helper for kmap_local_page() users in local filesystems
Date:   Mon, 27 Mar 2023 12:20:23 +0200
Message-ID: <2729240.9PvXe5no7K@suse>
In-Reply-To: <8232398.NyiUUSuA9g@suse>
References: <20230310204431.GW3390869@ZenIV> <8232398.NyiUUSuA9g@suse>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On sabato 11 marzo 2023 18:11:01 CEST Fabio M. De Francesco wrote:
> On venerd=EC 10 marzo 2023 21:44:31 CET Al Viro wrote:
> > 	kmap_local_page() conversions in local filesystems keep running into
> >=20
> > kunmap_local_page()+put_page() combinations; we can keep inventing names
> > for identical inline helpers, but it's getting rather inconvenient.  I'=
ve
> > added a trivial helper to linux/highmem.h instead.
>=20
> Yeah, "put_and_unmap_page()". Nice helper :-)

[snip]

Hi Al,=20

> Why did you name it "put_and_unmap_page()" instead of=20
"unmap_and_put_page()",
> for we always unmap first _and_ put the page immediately the unmapping?
>
> It seems it want to imply that instead we put first and unmap later (which
> would be wrong). That name sounds misleading to me and not sound (logical=
ly
> speaking).
>=20
> Am I missing some obscure convention behind your choice of that name for =
the
> helper?

Can you please explain what I'm missing behind your motivation?

Thanks,

=46abio

P.S.: Adding Ira to the Cc list, since he's been doing kmap() and=20
kmap_atomic() conversions long time before I too started with them.


