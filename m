Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05F6817C7BB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 22:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgCFVSC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 16:18:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36063 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgCFVSC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 16:18:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id s5so77046wrg.3;
        Fri, 06 Mar 2020 13:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=p6Org6UXIrzDwowUXc2sjZeWM3eA1JdxHEoOPSQKwXg=;
        b=cvgNX6L3bTfW2fGWA9k22gcf/KhCHZ9ExnPWWJEErpHTmKDq30VAynAmceOCadITbe
         I/ExetjXaPI4YG2nj4ajs3z2T/iWQdO0nqn9HkOH1c2CdJV9fm3SzNsq7Qhu68hKffLl
         NljWlntUtHdt1GtrTEZTM1Rm6MI9ZOF2QPeT8xowEvR8nw1iLmBEx05LLIhIKCYcfqKX
         LoZHsHk2poTWDEIpxVJOcxD5qIbNak2Gx6Sgu572c6FB6fDQ2scdhTU8RIgH7bn39sqL
         +3KC0mmOfZlhbTPKYfy6n5vQxf5h4CaG7Ze3L36TSdJJ+ffROSEHbxGwELOvRHynl0N5
         Kpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=p6Org6UXIrzDwowUXc2sjZeWM3eA1JdxHEoOPSQKwXg=;
        b=ZMpA0na8SjSEHE4we5WBwOM+eU6q+vNgC9vfySzZzpqxcbhJ6dCp0iyiYNasuZK8V4
         12FSHzuTH02eTIyR5jPbx/yIdwIyyV2rnq/4ohRyKIQTtkLSc62NjUWSVRX1IxN+9EBP
         qOE4aaHRVED9rjvqnG1WSHcyuwvMJVvSQKMH2ShTkQHGWsaknvkv7HO6WNKxYUAHaJvJ
         j1c0F4bp2h3VtHrwS8PFFddg7G4oIGh0jhgXW7Zub8VXsMFgWHixsbnVk17BE8GGDw5l
         wNapD2dQkboaOZCqUxms0E03/d1I7sMzxg4pZJj1oNk7Tljq5irK7Hwej/Tb6c6cf0nR
         hdAA==
X-Gm-Message-State: ANhLgQ0x2Sm80BEAn4AzX4QK2KeUudkCHvuF6/MrneqMWmVd6z1DueYd
        c6mpFE0YGM9FaV5yHRNiHCY=
X-Google-Smtp-Source: ADFU+vsVLlePqEyfb4RvbS3zrbvkxMTYwO8c1UN9KLRwWFNh+J1N+jIVCdVfuDojuHpXx4saKzQBdg==
X-Received: by 2002:a5d:66cc:: with SMTP id k12mr661050wrw.157.1583529479110;
        Fri, 06 Mar 2020 13:17:59 -0800 (PST)
Received: from felia ([2001:16b8:2d12:b200:a423:5ade:d131:da88])
        by smtp.gmail.com with ESMTPSA id q16sm35313652wrj.73.2020.03.06.13.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 13:17:58 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Fri, 6 Mar 2020 22:17:49 +0100 (CET)
X-X-Sender: lukas@felia
To:     Joe Perches <joe@perches.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust to filesystem doc ReST conversion
In-Reply-To: <e43f0cf0117fbfa8fe8c7e62538fd47a24b4657a.camel@perches.com>
Message-ID: <alpine.DEB.2.21.2003062214500.5521@felia>
References: <20200304072950.10532-1-lukas.bulwahn@gmail.com> <20200304131035.731a3947@lwn.net> <alpine.DEB.2.21.2003042145340.2698@felia> <e43f0cf0117fbfa8fe8c7e62538fd47a24b4657a.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Wed, 4 Mar 2020, Joe Perches wrote:

> On Wed, 2020-03-04 at 21:50 +0100, Lukas Bulwahn wrote:
> > 
> > On Wed, 4 Mar 2020, Jonathan Corbet wrote:
> > 
> > > On Wed,  4 Mar 2020 08:29:50 +0100
> > > Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > > > Jonathan, pick pick this patch for doc-next.
> > > 
> > > Sigh, I need to work a MAINTAINERS check into my workflow...
> > > 
> > 
> > I getting closer to have zero warnings on the MAINTAINER file matches and 
> > then, I would set up a bot following the mailing lists to warn when anyone
> > sends a patch that potentially introduces such warning.
> 
> Hey Lukas.
> 
> I wrote a hacky script that sent emails
> for invalid MAINTAINER F: and X: patterns
> a couple years back.
> 
> I ran it in September 2018 and March 2019.
> 
> It's attached if you want to play with it.
> The email sending bit is commented out.
> 
> The script is used like:
> 
> $ perl ./scripts/get_maintainer.pl --self-test=patterns | \
>   cut -f2 -d: | \
>   while read line ; do \
>     perl ./dump_section.perl $line \
>   done
> 

Thanks, Joe. That is certainly helpful, I will try to make use of it in 
the future; fortunately, there really not too many invalid F: patterns 
left, and I can send the last few patches out myself.

Lukas
 
