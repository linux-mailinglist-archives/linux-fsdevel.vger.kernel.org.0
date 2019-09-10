Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEE4AE3B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2019 08:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390922AbfIJG16 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Sep 2019 02:27:58 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:33175 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbfIJG16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:27:58 -0400
Received: by mail-ot1-f41.google.com with SMTP id g25so15467797otl.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2019 23:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=VjaVCvw7Es75Y87+TuInwO6wTJKd4OwHl3OoUN4X21M=;
        b=bTH63OdzbSyyfI3d3StOzzqmtb8AS1gEb5tEBg2YYe6kYDPWrrnohRw63Mv+AtEFPC
         eWNn1hnQMGWcD0GEOas6omOi5qouS2jNfDof/HckHf5JLRnmWPAwc388uCLFLM9dfg0Z
         llevmXvb0BEBOQlCbvsjl5BXxCyjHnTz48VK+mBewdU9j3H+/XnF3Bk09dYGl6HDXlef
         8u+z1a7c+bXliR0jZL30DYnFg1jPYy8B1rPnH+Dw/peMdjW576iR82HAgFKWA4Ns0bqL
         fh2Uau3mMqTelW1lljFchIkflqhhm+Ox+mJZopP4Y/OokuzULyG94TsqWJfseQeocDuj
         qhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=VjaVCvw7Es75Y87+TuInwO6wTJKd4OwHl3OoUN4X21M=;
        b=HfpFnIa85DtdN5Ue/NxHeRsb+3sXuACit2rQU9C2m/fSUTlLw4p6GyyVSmDPvk+uBF
         QHXn6AD6IGRsKovZyIfArqy7k4Iy3IAdYNoq3h70ZcZ0zZI0/Vb54+4CiqKN5YW9UNDu
         6pSVhfmIF9u/eBt17q96U3JoCSm3fF5WUuKo2Xctr6/JnSvb7pNesMznxGkEwpOk0tzR
         phVp+YZblMbgrUWgMC/W0wCftBggVGomQczpcl7g8u58cfMn13ccXLJZUyQw3o1VKsAp
         EsUN5J8HvSYBbp8nViVhemoS38v5Pz019Z/1PHnHUIF62NREbpNvEv7a34kJrqKbBZCl
         FQUg==
X-Gm-Message-State: APjAAAUdiBwJ/8i0x2MLqZZwZx721y6DZK8Q/TrlQ1sPyHi6OYm/ROr+
        DRNftey75WU2caG5UF42puiSbQ==
X-Google-Smtp-Source: APXvYqyr/5ZSWwhxcxVoEpZMzkdjrJd95+TstKsGF8R+eAlLsTaGkBCm/1mlMp5lP9ovy746SFUEIQ==
X-Received: by 2002:a05:6830:184:: with SMTP id q4mr20085871ota.128.1568096876476;
        Mon, 09 Sep 2019 23:27:56 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e7sm3507003otp.64.2019.09.09.23.27.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Sep 2019 23:27:55 -0700 (PDT)
Date:   Mon, 9 Sep 2019 23:27:15 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     Hugh Dickins <hughd@google.com>,
        kernel test robot <rong.a.chen@intel.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, lkp@01.org
Subject: Re: [vfs]  8bb3c61baf:  vm-scalability.median -23.7% regression
In-Reply-To: <20190909035653.GF1131@ZenIV.linux.org.uk>
Message-ID: <alpine.LSU.2.11.1909092301120.1267@eggly.anvils>
References: <20190903084122.GH15734@shao2-debian> <20190908214601.GC1131@ZenIV.linux.org.uk> <20190908234722.GE1131@ZenIV.linux.org.uk> <alpine.LSU.2.11.1909081953360.1134@eggly.anvils> <20190909035653.GF1131@ZenIV.linux.org.uk>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 9 Sep 2019, Al Viro wrote:
> 
> Anyway, see vfs.git#uncertain.shmem for what I've got with those folded in.
> Do you see any problems with that one?  That's the last 5 commits in there...

It's mostly fine, I've no problem with going your way instead of what
we had in mmotm; but I have seen some problems with it, and had been
intending to send you a fixup patch tonight (shmem_reconfigure() missing
unlock on error is the main problem, but there are other fixes needed).

But I'm growing tired. I've a feeling my "swap" of the mpols, instead
of immediate mpol_put(), was necessary to protect against a race with
shmem_get_sbmpol(), but I'm not clear-headed enough to trust myself on
that now.  And I've a mystery to solve, that shmem_reconfigure() gets
stuck into showing the wrong error message.

Tomorrow....

Oh, and my first attempt to build and boot that series over 5.3-rc5
wouldn't boot. Luckily there was a tell-tale "i915" in the stacktrace,
which reminded me of the drivers/gpu/drm/i915/gem/i915_gemfs.c fix
we discussed earlier in the cycle.  That is of course in linux-next
by now, but I wonder if your branch ought to contain a duplicate of
that fix, so that people with i915 doing bisections on 5.4-rc do not
fall into an unbootable hole between vfs and gpu merges.

Hugh
