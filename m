Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6054FA416F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 02:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfHaAsq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 20:48:46 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:42572 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727304AbfHaAsq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 20:48:46 -0400
Received: from mr1.cc.vt.edu (mr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:31:1732:8aa4])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x7V0migN019688
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2019 20:48:44 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x7V0md24016946
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2019 20:48:44 -0400
Received: by mail-qt1-f199.google.com with SMTP id i19so8900912qtq.17
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2019 17:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=hAvYFRbZfg6zVKj/Y6OX1sKU/hy8hbS+8/7teBR1etI=;
        b=hizH0XPSr2uQa8OL2XdfwnrTDdbEe7f9yq54c7zwOyObUpwo8DNK1gjGvtJhzsntPv
         ry/2+LTByZit58nugn5yxTv3FSgFt2H8A80SDyiH0JyWHHYOb+iqzPekB57DG98nHWUI
         4igukDcl0UFOjs20WbXnwXeNH1xw2x4SlpHwoSFWLLNynEtZyQw/qR4eEHNbwhMLDYX+
         FvKASwa9LksNgMcCSeM8C59R0kTptfbff210tNxzqYt449qUt+EvcyTxiVxoEr3EBCED
         youyYiC1tidvPnHxHSSrxGKRNW5gPaTXbodGrUcRsLywm9Q1j3pK5p+5ylRoMZiiHE92
         9U1g==
X-Gm-Message-State: APjAAAVlah3G1eflMX8faVLZEaH0kXQwohe8AoKQtNciltSudRfl7VrM
        41fzPAMTCosVNK4BiLI20++3XkOxRmlox94UwaPynjSiZF4Bg7Cn1tw0Hw6RxGXpZlI56wjzy0a
        yhg9SgtG2DIvR6/DRRxvmssc75OQH4/ZfZHl6
X-Received: by 2002:a37:9cd6:: with SMTP id f205mr5258319qke.500.1567212519204;
        Fri, 30 Aug 2019 17:48:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyg4lACJyMP8yOX1eZRN6N/NhySpk8/KLFYW7wXKB3NH2+Gf8BSvXz6nfA7jeXnRmC0rsU1bQ==
X-Received: by 2002:a37:9cd6:: with SMTP id f205mr5258309qke.500.1567212518966;
        Fri, 30 Aug 2019 17:48:38 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4340::ba0])
        by smtp.gmail.com with ESMTPSA id q5sm756414qte.38.2019.08.30.17.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 17:48:37 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/exfat - by default, prohibit mount of fat/vfat
In-Reply-To: <20190830164503.GA12978@infradead.org>
References: <245727.1567183359@turing-police>
 <20190830164503.GA12978@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1567212516_4251P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 30 Aug 2019 20:48:36 -0400
Message-ID: <267691.1567212516@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1567212516_4251P
Content-Type: text/plain; charset=us-ascii

On Fri, 30 Aug 2019 09:45:03 -0700, Christoph Hellwig said:
> On Fri, Aug 30, 2019 at 12:42:39PM -0400, Valdis Klētnieks wrote:
> > Concerns have been raised about the exfat driver accidentally mounting
> > fat/vfat file systems.  Add an extra configure option to help prevent that.
>
> Just remove that code.  This is exactly what I fear about this staging
> crap, all kinds of half-a***ed patches instead of trying to get anything

Explain how it's half-a**ed.  You worry about accidental mounting, meanwhile
down in the embedded space there are memory-constrained machines that
don't want separate vfat and exfat drivers sitting around in memory. If you
have a better patch that addresses both concerns, feel free to submit it.

> done.  Given that you signed up as the maintainer for this what is your
> plan forward on it?  What development did you on the code and what are
> your next steps?

Well, the *original* plan was to get it into the tree someplace so it can get
review and updates from others.  Given the amount of press the Microsoft
announcement had, we were *hoping* there would be some momentum and
people actually looking at the code and feeding me patches. I've gotten a
half dozen already today....

Although if you prefer, it can just sit out-of-tree until I've got a perfect driver
without input or review from anybody.  But I can't think of *any* instance where
that model has actually worked.

--==_Exmh_1567212516_4251P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXWnD4wdmEQWDXROgAQI2Lw//ZXt83MXiFP9wPn3IqMTB50EfGSlSsowM
dAIDTTKohlGZ8qPNUEnt1wWQOqXFpUeUtWW5G9s8JVX1MnxNIiE8/XwLQr5httxD
DyoYehuYvM41YqC8QsgxbRMOnVcQZHROYcRwm6DBVOWxWJrqkt1PngexfeWPgvNt
h++jC9RJQXN/buNSAUl4fGGWZf+3r5d0hAfQhyfz1NLQO5PToO2RBRpVHQ/6o9Ej
kkQ1fePFSc734vf8hVishIRfM+2BnSHXeEKHEsZGuUQcQJ1wrLTGxT967c+cfiZI
27lWjiMa8OZ+hhfo4LSQpnQYU3elfGlRNio42MTob11e4R1vQyT1pc2+HajKbcC4
Dl82qD13xNcWQHx8g1wSt6PYRHQMqqtZwA+RWxqyN867U58TfzHkHlsZ+FDXu4VS
WwyJDx/jMRUieE7wYciAbOOklAmfin+AvIWuDQS6MiX1o9npi7kjkkT3H0DbeP5i
oaBUDWrJuQnFsSaiJW8yE6V22H2nhYurOkZz34pBJIIcVWArqOnqEnBKkr8zzhQJ
APw96YyeZblM4QmwoBuMAbs9VWsw40JZTN8I2Y0Asd2y+6VB3u+VFYgZSOpt1u0G
MbakTOp8QReP7qVovapDasaCstzv2/mFrHCQaOJxTnW8tmwiyJygijQLRLpE4akI
l9vn7sIxRXo=
=uM87
-----END PGP SIGNATURE-----

--==_Exmh_1567212516_4251P--
