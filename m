Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8328117837E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 20:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgCCT44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 14:56:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38017 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgCCT44 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:56:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id u9so4175301wml.3;
        Tue, 03 Mar 2020 11:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=37CbNVhbFufQTtYlKIlj10Tv/j2n35ElGgexHS8GKhw=;
        b=DcahoXq4wmP2g0InoVkEwZ9ne7HYZGOtIqHwpbrH78ZPhyKlMIXNP25prL6w7y7VhG
         IDRfIt4mrPa2RcIg883wHjiL/fBhJXhCFqg7PTsuNNtj6EnVB9vzmMDZ/jDGYMarV5tD
         W8TmNFNox9D/azYx15FF/FnRDwB15s8sCS0N6jjAYHzHwg7tevIXZT5bNokjUfiEcfco
         AieDlCJuZET+lNb7Pdr56OdJ9XUJRigr7NOtPCYNhRtaeYSrL4/UZudg3pwy7oyLxyRU
         QFomldIxO6LF6IbxPB82t1hh7xrm4Qth8lfCQdhl4ZTsun/hdWxgqJGjCNPKb/Iq+O/p
         SJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=37CbNVhbFufQTtYlKIlj10Tv/j2n35ElGgexHS8GKhw=;
        b=JdRmTNeWwrEGZiLJf6xH4VI7DtKk1IqGCBYaQyWId7S7JdTkF8WtOoaAdy6Khk3GLj
         A5aHIVBm0xon9xmPzz4h+F6qbP63VdokNkw0JF4PPYRPy7Og9ENEiYvetRNkz+/VkbHF
         IJuUkkUBvfvyx1b3kO6QuUB3RBat+94qmrJOGcErn1G1xSYitxdE8TGhDnh0fKt5xvdt
         UJYTsLA6K9jvnW4KrwJ44fNSyvh4iIuNWfRlzfcrwlzN03to+IwyMTc+alJS0Vuf0Nn3
         Xlhjwy1mxwm46fFskJRH+Qscc4hS0yj11CCuCFjiVicMuWoB+mOFRy9Ez4G/xuBFcDPw
         H3ZQ==
X-Gm-Message-State: ANhLgQ1BlBscY1sGtkbiPM/548tAunOWw+rW4kxLhNcJ6bHpA++hZz4o
        G9NSJlcG+OIwO9syjFHN/sS3F3U=
X-Google-Smtp-Source: ADFU+vtr14ipf1Gev15PJYSi9koe25wZb3R+6IYXA1pPllZz5T0/1vLfbQLViYlX4FJ+cTPF976Ziw==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr202513wmc.134.1583265414942;
        Tue, 03 Mar 2020 11:56:54 -0800 (PST)
Received: from avx2 ([46.53.249.49])
        by smtp.gmail.com with ESMTPSA id p10sm30460639wrx.81.2020.03.03.11.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 11:56:54 -0800 (PST)
Date:   Tue, 3 Mar 2020 22:56:50 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Simplify /proc/$pid/maps implementation
Message-ID: <20200303195650.GB17768@avx2>
References: <20200229165910.24605-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200229165910.24605-1-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 29, 2020 at 08:59:05AM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Back in 2005, we merged a patch from Akamai that sped up /proc/$pid/maps
> by using f_version to stash the user virtual address that we'd just
> displayed.  That wasn't necessary; we can just use the private *ppos for
> the same purpose.  There have also been some other odd choices made over
> the years that use the seq_file infrastructure in some non-idiomatic ways.
> 
> Tested by using 'dd' with various different 'bs=' parameters to check that
> calling ->start, ->stop and ->next at various offsets work as expected.

/proc part looks OK, I only ask to include this description into first
patch, so it doesn't get lost. Often 0/N patch is the most interesting
part of a series.
