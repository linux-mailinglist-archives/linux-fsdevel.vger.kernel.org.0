Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273B45F757B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 10:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJGIru (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 04:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGIrt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:47:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD41B97BC;
        Fri,  7 Oct 2022 01:47:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36D24B821FD;
        Fri,  7 Oct 2022 08:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE80AC433B5;
        Fri,  7 Oct 2022 08:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665132466;
        bh=JvsJAjK2viLhsl8prgm3Okm0KP7YFzOENNR4sX/iqN4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nXruCk3dbtw+hIqHFFdug4hTm3jQ1IJdKDoOosX+TkLI9KFp37Pn5lNkLBoG4/mZv
         gl8zj9kXkl9ng3n0TZ29lUD7WatF1kjrfYtMeA3ARTvmNrZdPOsWL6GrMLc/4icpxf
         q5JsV5KcM8JKZGjir/Gyg1rDJhs7AzE4ii184f5YvjkbW9exzAppjdu6Bogem83WUr
         NZ/JfLtJS1ynRk46IEQJD4TxsVIM8p0krK/vy4WqTCyt8IYk5FPPGA8BGnUjEh7vyW
         VFrQLmHMjlfWV7KAXR4MoHd5T3tAew98vKXRK7Kq+Wf4iAUwXpuIRubwX+pS+vqj6j
         S9jmbg1qeKJRA==
Received: by mail-lf1-f44.google.com with SMTP id d6so6284698lfs.10;
        Fri, 07 Oct 2022 01:47:45 -0700 (PDT)
X-Gm-Message-State: ACrzQf0LVIalsa6aZMmerNMugKwpfwfgcx1y712KGl2wDvqLPLDVnuHg
        jUPyaTQP1gMzRferTgArtZIro/CIZH9T08VZ16Q=
X-Google-Smtp-Source: AMsMyM44yFaEOObizVHcR/26W5DJQcgwhUIpkSjU8hV6Nx+Zcb8O5A+eclJsmCZAfvMMSTvo7bD6iPEYReVnj3we8TA=
X-Received: by 2002:a05:6512:261b:b0:4a1:abd7:3129 with SMTP id
 bt27-20020a056512261b00b004a1abd73129mr1528800lfb.637.1665132464012; Fri, 07
 Oct 2022 01:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221006224212.569555-1-gpiccoli@igalia.com> <20221006224212.569555-8-gpiccoli@igalia.com>
 <202210061616.40497D6C@keescook>
In-Reply-To: <202210061616.40497D6C@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 7 Oct 2022 10:47:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGg9moz0Fg+wFYg2GjLD2gW1RGmQqT3mu+cNi0KuYyAqA@mail.gmail.com>
Message-ID: <CAMj1kXGg9moz0Fg+wFYg2GjLD2gW1RGmQqT3mu+cNi0KuYyAqA@mail.gmail.com>
Subject: Re: [PATCH 7/8] efi: pstore: Follow convention for the efi-pstore
 backend name
To:     Kees Cook <keescook@chromium.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 7 Oct 2022 at 01:16, Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 06, 2022 at 07:42:11PM -0300, Guilherme G. Piccoli wrote:
> > For some reason, the efi-pstore backend name (exposed through the
> > pstore infrastructure) is hardcoded as "efi", whereas all the other
> > backends follow a kind of convention in using the module name.
> >
> > Let's do it here as well, to make user's life easier (they might
> > use this info for unloading the module backend, for example).
> >
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
>
> Looks fine to me. Ard, if you don't object, I can carry this in the
> pstore tree.
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>
