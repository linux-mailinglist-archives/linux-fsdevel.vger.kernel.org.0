Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA394A74E3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 16:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345158AbiBBPos (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 10:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiBBPor (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:44:47 -0500
Received: from mail-out-4.itc.rwth-aachen.de (mail-out-4.itc.rwth-aachen.de [IPv6:2a00:8a60:1:e501::5:49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE5EC061714;
        Wed,  2 Feb 2022 07:44:46 -0800 (PST)
X-IPAS-Result: =?us-ascii?q?A2AEAABmpvph/6QagoZaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFGBQEBAQELAYFRgixqhEmII4hznFOBfAsBAQEBAQEBAQEIA?=
 =?us-ascii?q?T8CBAEBhQUCg1sCJTQJDgECBAEBAQEDAgMBAQEBAQEDAQEGAQEBAQEBBQSBH?=
 =?us-ascii?q?IUvRoZDAQUjVhALDgoCAiYCAhAEMxYOBYYbAa5qgTGBAYhWgScJAYEGKgGHK?=
 =?us-ascii?q?4cugimEPz6HXYJlBJJDhDKRWoMvRpdAkmEHghBUZaARg3KSQAKRVJZKgkeje?=
 =?us-ascii?q?wIEAgQFAhaBYYIVMz6DOFEXAg+ccEEyOAIGCwEBAwmCOoMKJhOHTwEB?=
IronPort-Data: A9a23:uKBOEaBAp+D6WxVW//ziw5YqxClBgxIJ4kV8jS/XYbTApDoggjIDn
 WtNWj+Gaf2PM2b3fdxzPNjn9BhXvpOAnINqOVdlrnsFo1CmCCbmLYnDch2gb3v6wunrFh8PA
 xA2M4GYRCwMZiaA4E/ra9ANlFEkvU2ybuOU5NXsZ2YhFWeIdA970Ug5w7Rh2NYy6TSEK1rlV
 e3a8pW31GCNhmYc3lI8s8pvfzs24ZweEBtB1rAPTagjUG32zhH5P7pDTU2FFEYUd6EPdgKMb
 7uZkOvprjuxEyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhlfc21
 vBtuI6MEBoLL/2diPkRWAdZKnQrVUFG0OevzXmXq9OPz0DWNmCwhvwoFl4qPcgR9qB7DAmi9
 9RBc2xLN0vbwbjohuvlFoGAhex6RCXvFIYWtXd91nfWF/E9WrjZXLnKoNZR1zc9gIZCEJ4yY
 uJAMmY/PUSdM0In1lE/LJR5gb7voUPGTCxihleqtLMIwTjs9VkkuFTqGJ+PEjCQfu1ckkGSv
 GPX9mLRDRQTNdjZwj2AmlqlhffKtSf6Xp8CUbO/6/hmiUGSwWpVDwcZPXO4rPSigUm5WPpUK
 1YT/yszqO417kPDZsf8RRqQsnOCvwBaX9tWDv187xuCjLfXiy6UDGkJQjNbbfQ2sc4tXj0t0
 BmCmNaBLThutqCFDHyG+rqKoDeaJycYNykBaDUCQA9D5MPsyKk3jxTSXpNmFYa2kNT+Gnf32
 T/ihCw/gagDyM4Czam2+1HBjBqyqZXTCA04/APaWiSi9AwRWWK+T5a39VjW/bNbcMOQCEOeo
 HhBksTY4O1m4YyxqRFhid4lRNmBj8tp+hWF6bKzN/HNLwiQxkM=
IronPort-HdrOrdr: A9a23:V2VN5KBGBMWHopDlHemx55DYdb4zR+YMi2TDGXoedfUzSL38qy
 nOpoV46faaslsssR0b9exoW5PwIk80l6QV3WB5B97LN2PbUQCTTL2Kg7GM/wHd
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,337,1635199200"; 
   d="scan'208";a="134898587"
Received: from rwthex-s4-a.rwth-ad.de ([134.130.26.164])
  by mail-in-4.itc.rwth-aachen.de with ESMTP; 02 Feb 2022 16:44:45 +0100
Received: from localhost (2a02:908:1069:d8e0:9e36:ff87:655a:5f05) by
 rwthex-s4-a.rwth-ad.de (2a00:8a60:1:e500::26:164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 2 Feb 2022 16:44:44 +0100
Date:   Wed, 2 Feb 2022 16:44:44 +0100
From:   Magnus =?utf-8?B?R3Jvw58=?= <magnus.gross@rwth-aachen.de>
To:     Alexey Dobriyan <adobriyan@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] elf: Relax assumptions about vaddr ordering
Message-ID: <Yfqm7HbucDjPbES+@fractal.localdomain>
References: <YfF18Dy85mCntXrx@fractal.localdomain>
 <202201260845.FCBC0B5A06@keescook>
 <202201262230.E16DF58B@keescook>
 <YfOooXQ2ScpZLhmD@fractal.localdomain>
 <202201281347.F36AEA5B61@keescook>
 <20220201144816.f84bafcf45c21d01fbc3880a@linux-foundation.org>
 <YfqgLmk9+4W50EEB@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <YfqgLmk9+4W50EEB@localhost.localdomain>
User-Agent: Mutt/2.1.5 (31b18ae9) (2021-12-30)
X-Originating-IP: [2a02:908:1069:d8e0:9e36:ff87:655a:5f05]
X-ClientProxiedBy: RWTHEX-S2-B.rwth-ad.de (2a00:8a60:1:e500::26:155) To
 rwthex-s4-a.rwth-ad.de (2a00:8a60:1:e500::26:164)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Wed, Feb 02, 2022 at 06:15:58PM +0300 schrieb Alexey Dobriyan:
> On Tue, Feb 01, 2022 at 02:48:16PM -0800, Andrew Morton wrote:
> > On Fri, 28 Jan 2022 14:30:12 -0800 Kees Cook <keescook@chromium.org> wrote:
> > 
> > > Andrew, can you update elf-fix-overflow-in-total-mapping-size-calculation.patch
> > > to include:
> > > 
> > > Fixes: 5f501d555653 ("binfmt_elf: reintroduce using MAP_FIXED_NOREPLACE")
> > > Cc: stable@vger.kernel.org
> > > Acked-by: Kees Cook <keescook@chromium.org>
> > 
> > Done.
> > 
> > I'm taking it that we can omit this patch ("elf: Relax assumptions
> > about vaddr ordering") and that Alexey's "ELF: fix overflow in total
> > mapping size calculation" will suffice?
> 
> Yes, it is same patch conceptually.
> It should work, but those who can't play Bioshock are better test it.

Yes it works.

Although the change from unsigned int to int is not necessary in the
first place, as you can avoid the -1 initialization for min_addr by
simply using ULONG_MAX, as can be seen in my patch.
