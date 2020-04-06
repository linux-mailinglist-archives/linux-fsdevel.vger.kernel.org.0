Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 254E019FD60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 20:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgDFSpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 14:45:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44227 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgDFSpK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:45:10 -0400
Received: from mail-lj1-f197.google.com ([209.85.208.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1jLWk8-0006QA-3S
        for linux-fsdevel@vger.kernel.org; Mon, 06 Apr 2020 18:45:08 +0000
Received: by mail-lj1-f197.google.com with SMTP id 76so2142329ljf.22
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Apr 2020 11:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35u7sIzL2v+ZtiB13vYxkmAljAmMWY1VBaJPchGChPU=;
        b=j0PD2OXl7bgY+g2SvWDs8NkzprMIO8q93tKiYhFyM4lzh82JdCUvPK1slfFe1IZ/Ls
         4Iy7LScZUWN8HnwzWN2jfrmvKB1JKibmDW7jvCvBVESevHPkkFOutQxFl7t7i6vYS2mr
         c00KChYrjhVI4Xs6IWOijz2axXzglMqc4DPgTrUfqA6ndO9F19Itvb+6fCoKiNwbCECa
         d8HSzAytELbb/af3EPFdyNR5OJz0s03XJVcPt75UEIQORB0gWBqol9mw+O3LM6ydzdB5
         6QGCNum72Q+P+jHLHZc4wmDAqElse6PU5sYdm5qsI9Ba2tlfwdY85t4bO1DioR3L9FEG
         tQzQ==
X-Gm-Message-State: AGi0PuYrGybUpAaVb3TrtLIUsJ7bkDGd3vzh9BMGA+SIYERI5jYrK5pR
        DjuRSZxdFsAV+LrTHD3kF7g3oyvx5vBO8dQHBZBQkYoEXCO+SYaAAsxtpOSosuDAomHJyVHYpKX
        IIV65p16NBJh1S+B67S8+v0HvPa8RMPUOfmtULg1ZIAI5IsbNJO+g3CEHl48=
X-Received: by 2002:a2e:85c6:: with SMTP id h6mr388502ljj.218.1586198707562;
        Mon, 06 Apr 2020 11:45:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypIfgUD0+Npj1fpuxcNsRprQ6GCvlWvrh7CigDE9Ba3M6ZRRFnD0WowMDyU8FhSHaePkKFsdLtJmDNIULbInyv4=
X-Received: by 2002:a2e:85c6:: with SMTP id h6mr388490ljj.218.1586198707394;
 Mon, 06 Apr 2020 11:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200327223646.20779-1-gpiccoli@canonical.com>
 <d4888de4-5748-a1d0-4a45-d1ecebe6f2a9@canonical.com> <202004060854.22F15BDBF1@keescook>
 <CAHD1Q_xwR4OqsF8n3VJXknZ5QgpLWPQ3YTuztTgn0GTMR0vgKA@mail.gmail.com> <202004061136.8029EF3@keescook>
In-Reply-To: <202004061136.8029EF3@keescook>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Mon, 6 Apr 2020 15:44:31 -0300
Message-ID: <CAHD1Q_y_qzn7=skyDiFnU0cKNMEjiiNSeyK-jqy8qmEdzUKmpg@mail.gmail.com>
Subject: Re: [PATCH V3] kernel/hung_task.c: Introduce sysctl to print all
 traces when a hung task is detected
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        mcgrof@kernel.org, Iurii Zaikin <yzaikin@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vlastimil Babka <vbabka@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Awesome, no problem at all. And thanks for all the information and review =)
