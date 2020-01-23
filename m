Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70B5614732E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 22:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgAWVfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 16:35:22 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34402 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgAWVfW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 16:35:22 -0500
Received: by mail-lf1-f68.google.com with SMTP id l18so3495539lfc.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2020 13:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5JEo2S95QV9RzdysiSqX6sLlLVR7bGOobEMqZB4SbLo=;
        b=LrAqB744pt/J8vqkIc85K0oHNitxTEwLxcSEUaIu43WhAUvXxzMBCno2LvKfhQXu0L
         QMnDBsNc3YXR2shrIDVs0cUYKafdaONjLDcBPiNDFxzTadHp5C4whl76dAFOre9YwVzU
         SY5P5FuMOtoNfri/t2DbZOWE9hkwyIdKhD+6dX4Frdz9995yNciwne+2Og90Q1HkEPiX
         NuHYw4ugQZx1YCWveavpWPHRqj1dsxgKFKB39MCg2ouG++cHgAe6Ch91a9z0efCDXaHQ
         2k7yiw90gujkm3E+HDqwQmF2Ea0YT5OQ0JDQimumZ7sEChjjoRThspQXQ+9ucSEyluzb
         +R3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5JEo2S95QV9RzdysiSqX6sLlLVR7bGOobEMqZB4SbLo=;
        b=snPBD6SuKcHMSylEr+9je0TjAqi9rGY1fgVIqstwwlC6Lp5tusgb5QVyuUfugnH1qS
         bU5orgK1enF0BbAaxfZ8HNR3Sjq2KT2D/8Ho/WanY75Co8cNJiwyL6zE4B6tAoSTXO9R
         UYo63nt40aSeqnkFhZTcJBx7oDeTSZRdtiK0uloMIIW9tDxHELbPlHJMannHqF+j2UOb
         nN5pxiOkEGoOxQgoEp00DRQmYVvvBgc1YniuecUE5Y9j5MxunTuqc5QuP9PcL6OtXPMx
         N6GQOCUgLgk6ANYM+SL2KXHd/4B4I/TChfQa9vFxd0x8QRemL8NqTHHYZM/5w6e+gR+T
         27cg==
X-Gm-Message-State: APjAAAVbL7XmT6PbvVxoluIm5iP19+dRZSnhJplNTpgFhnBF5/hrJNW0
        V+TYgciUC221IyzknUshslWvzagFc0vNFYMJGv5M6w==
X-Google-Smtp-Source: APXvYqx0p8hvRbgBC26M9FVdzAYzLSri+D8u6aFzpfJCv9MmjQWjujEFU9JKr/o3Xmz+P0huC2zlxY0gHbxp1WC7mHE=
X-Received: by 2002:a19:c307:: with SMTP id t7mr5721872lff.166.1579815320173;
 Thu, 23 Jan 2020 13:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20200120223201.241390-1-ebiggers@kernel.org> <20200122230649.GC182745@gmail.com>
In-Reply-To: <20200122230649.GC182745@gmail.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Thu, 23 Jan 2020 13:35:08 -0800
Message-ID: <CA+PiJmRBM-0J+LAckrvzg_bxEF+EmjwG5_PzgiWJ7SQu219p2g@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] fscrypt preparations for encryption+casefolding
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 22, 2020 at 3:06 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> I've applied this series to fscrypt.git#master; however I'd still like Acked-bys
> from the UBIFS maintainers on the two UBIFS patches, as well as more
> Reviewed-bys from anyone interested.  If I don't hear anything from anyone, I
> might drop these to give more time, especially if there isn't an v5.5-rc8.
>
> - Eric

The patches look good to me. Thanks for the fixups.
-Daniel
