Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EECC39AAB9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 21:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhFCTOS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 15:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCTOS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 15:14:18 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FE5C061756
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jun 2021 12:12:33 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id w15so8460246ljo.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jun 2021 12:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5EDxCagl07bOh/Nv8oABAKO17kN+L9A+RY/dcpJKFLM=;
        b=UTljGEGQNYuxNXIn0v7XzxieUWCtnIsxzkRCecivfei0dzW5YoDgn0l5XlRffuAtRp
         9lRSLYrp3aHu78VwRpo49Xzw5AfLWYiO+J5j4JygA2mmEuyDFb9pNuPPxy5EAwi8/b+z
         1pN+oUWFghkmkRW6aHl9ejWgOUmra/8PfgAXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5EDxCagl07bOh/Nv8oABAKO17kN+L9A+RY/dcpJKFLM=;
        b=b7SZQIykdq0rGOIKnGU0eFhCPOZZCN10Vzw/+SnbQ3C4njf253bWNay4qFVdcDcsz7
         oC1sWjFp7lWMxa0QatMryHHkDJoEh81lN1XLke4OVxGAhK7yN+3erljIh1+n/8WyUNQw
         Kl5DvVROYPbk4+i5okh+eEVv4f2BdCFYRjqAV/WzyLXh3ZVTyJbwSdajpUcPkVZ7zvpM
         BPXfTn2T/LCZfPl2l8iy5+67ZB44ReZsumFp+tSFQbQVh3y4xWrKiPeqjH5E+G4HVwc9
         QXfpI71JHxs8Tl9s4imqV/YIp329mah2fLrZJhgWX2O0ltJXJPBKwFWnrNs+Pgqto0uk
         OkHQ==
X-Gm-Message-State: AOAM530c0VJhQ+Dc8WfyfHB2/h9PK5D/nmAPCGcnZ69p/u/cx7W4cw3T
        WuJyz3+eroQ5yNAfo/SO3uLTT8/qQDbIok4S
X-Google-Smtp-Source: ABdhPJx83CFKBr3voLddMRB3fhNkpncllaWy0w7t8JC69Ry8Qo//1uReIx9d/HOSXmfZQTpF4Fwy7A==
X-Received: by 2002:a2e:bf21:: with SMTP id c33mr626961ljr.28.1622747551318;
        Thu, 03 Jun 2021 12:12:31 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id y24sm451028ljy.15.2021.06.03.12.12.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 12:12:30 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id v8so10432206lft.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jun 2021 12:12:30 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr260545lfc.201.1622747549926;
 Thu, 03 Jun 2021 12:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <1622589753-9206-1-git-send-email-mlin@kernel.org>
 <1622589753-9206-3-git-send-email-mlin@kernel.org> <alpine.LSU.2.11.2106011913590.3353@eggly.anvils>
 <79a27014-5450-1345-9eea-12fc9ae25777@kernel.org> <alpine.LSU.2.11.2106021719500.8333@eggly.anvils>
 <CAHk-=wiHJ2GF503wnhCC4jsaSWNyq5=NqOy7jpF_v_t82AY0UA@mail.gmail.com> <alpine.LSU.2.11.2106031142250.11088@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2106031142250.11088@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Jun 2021 12:12:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNT0RhwHkLa14ts0PGQtVtDZbJniOQJ66wxzXz4Co2mw@mail.gmail.com>
Message-ID: <CAHk-=wiNT0RhwHkLa14ts0PGQtVtDZbJniOQJ66wxzXz4Co2mw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: adds NOSIGBUS extension for out-of-band shmem read
To:     Hugh Dickins <hughd@google.com>
Cc:     Ming Lin <mlin@kernel.org>, Simon Ser <contact@emersion.fr>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 3, 2021 at 12:07 PM Hugh Dickins <hughd@google.com> wrote:
>
> But the point that we've arrived at, that I'm actually now fairly
> happy with, is do *not* permit MAP_NOSIGBUS on MAP_SHARED mappings.

Yeah, if that's sufficient, then that original patch should just work as-is.

But there was some reason why people didn't like that patch
originally, and I think it was literally about how it only worked on
private mappings (the "we don't have a flag for it in the vm_flags"
part was just a small detail.

I guess that objection ended up changing over time.

            Linus
