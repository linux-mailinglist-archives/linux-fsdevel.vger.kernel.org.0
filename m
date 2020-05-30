Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186871E9356
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 21:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgE3TVO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 May 2020 15:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbgE3TVO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 May 2020 15:21:14 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFF6C03E969
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2020 12:21:14 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c21so1656184lfb.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2020 12:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6NkuvZ5wxpI0d7nxM1p2cSrZBIeJuPPcRbcbjWmyFH8=;
        b=L2gQT40oxwSdo4IdQediVzzXaQ9+LxXAgiK+MMr6jElRXz3IKpxvX2gNiIHXz8954v
         HtaR/MNXCphqAEFosDyOPCVSqQ3rs19dQLOuWT74IQyI0O7DyzRaJ/4J+KBp/TRoPDSz
         g1kWwuqmvYPoA233IXW/7crOLzFd3q6p7ha5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6NkuvZ5wxpI0d7nxM1p2cSrZBIeJuPPcRbcbjWmyFH8=;
        b=eHWBPG2NsTK0ZlbrlNXLTP5L8uGIKnl2a9ViFHQbtMEN/nPbeS1CXgZSrmj6iauWeG
         Hg0mUvIhFWqJdLYxY5NAEDndQSYUbX4hI8a2q4orwMooB9/cZjMwkkKgofFNeuNln6S0
         n20Gze0L1M+hTKYvN24+gDwUD1lqhTlc5t6QHYWPq/nYYOmJ+jSfocBDFXI2iEu4ov09
         JRueyICRhG4RlzmIIWlQhLN8hetv5teRiJn9yQRUvndIayHyD65vgXVArC0OyMK/npRq
         dXGZm4e++KWC8ZrTv7uGtrE/Exg7MZpog6nvA2j4akXyhZSC3k2lKplbZUhl84czrks0
         +7vA==
X-Gm-Message-State: AOAM532P2Fvn1hmU+TvIfTIt683bLhW7mWLWvlPYEH/BYNefnNLGgDal
        EsfYzsZzmLIRJ68ngunxG+f76SQ1W8A=
X-Google-Smtp-Source: ABdhPJyi9CDljfI0KoYUEWZ0+zBzKHJ3Tx29ZF3HHCL26NcBjPeXYCs44ZMgcT0kwFx+kATJFadP/A==
X-Received: by 2002:a19:6cd:: with SMTP id 196mr7391628lfg.216.1590866472052;
        Sat, 30 May 2020 12:21:12 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id l19sm2775407lja.68.2020.05.30.12.21.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2020 12:21:11 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id c12so1628064lfc.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2020 12:21:10 -0700 (PDT)
X-Received: by 2002:a19:6a0e:: with SMTP id u14mr7258369lfu.192.1590866470633;
 Sat, 30 May 2020 12:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200528234025.GT23230@ZenIV.linux.org.uk> <20200529232723.44942-1-viro@ZenIV.linux.org.uk>
 <20200529232723.44942-8-viro@ZenIV.linux.org.uk> <CAHk-=wgq2dzOdN4_=eY-XwxmcgyBM_esnPtXCvz1zStZKjiHKA@mail.gmail.com>
 <20200530143147.GN23230@ZenIV.linux.org.uk> <81563af6-6ea2-3e21-fe53-9955910e303a@redhat.com>
 <CAHk-=wiW=cKaMyBKgZMOOJQbpAyeRrz--o2H_7CdDpbn+az9vQ@mail.gmail.com>
 <20200530183853.GQ23230@ZenIV.linux.org.uk> <CAHk-=wjmCBXj0==no0f9Og6NZuAVWPEFXUgRL+fRmJ8PovbdPQ@mail.gmail.com>
 <20200530191424.GR23230@ZenIV.linux.org.uk>
In-Reply-To: <20200530191424.GR23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 May 2020 12:20:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg03AwbLH0zLRbOOQR_cZD89dM0KMU-uLMkG2sG9K_yag@mail.gmail.com>
Message-ID: <CAHk-=wg03AwbLH0zLRbOOQR_cZD89dM0KMU-uLMkG2sG9K_yag@mail.gmail.com>
Subject: Re: [PATCH 8/9] x86: kvm_hv_set_msr(): use __put_user() instead of
 32bit __clear_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 30, 2020 at 12:14 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> > And none of that code verifies that the end result is a user address.
>
> kvm_is_error_hva() is
>         return addr >= PAGE_OFFSET;

Ahh, that's what I missed. It won't work on other architectures, but
within x86 it's fine.

                  Linus
