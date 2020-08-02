Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C009235593
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Aug 2020 07:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgHBFZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Aug 2020 01:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgHBFZv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Aug 2020 01:25:51 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6ECC06174A
        for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2020 22:25:50 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id d14so32531044qke.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2020 22:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Q88G6sppSxIX0pplwKPE04Ypo1Vd7dthljabY9nsEyY=;
        b=c1aDkf3N1oirRr4hEjjSjDfKhY6HLj9eJttmIu2Zh4YiBtsYG9vO6/uKfwRucL4I7R
         n2h84v4SMqNOnLTrc/lmWb6QE89nkwunpI0oW9RatURybcfZH4HE+Q2cehx7TW3q0rUb
         vNTJLMrkyzRQpoJtrJZM1+FqoEsBYN0NvFHXF8exk5PbDSwm0ScJ2KKG1QVfR5OK3ltL
         kOafCVTIDWPLbmBc21pOmMscRXKH5rH2pkRXJyjivN9nRy7nd+gdqEoejrRvFL2Xhq8f
         FFWtGXMC/ybACTFbTlJhCX0Eo2Ihvx2BtkVfpVm/KWqGNcUAfD0xqxFcmOqZ2WwAF13+
         DlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Q88G6sppSxIX0pplwKPE04Ypo1Vd7dthljabY9nsEyY=;
        b=cEGII/AwKMhbGFI3TG5YI4A/Bq7eALYLvgy7583zmPSY9TU18BlQjtpwMyBUf2II8i
         eUcAK9f673DV26RfBnHDUsub3VubnqBwPk5O68wFhULYahakDngrUkFBEdzdyPlDTM+w
         oY93imTY0g69MbhfDkxaDKzUBzZa3SAhBwXZ8E3+1DY8zn3QO/6vjLU4ry5OY79ByjRN
         Y2cnf9JEg+7GiBPE/Tuq1wwKD8pPZBT6RzoBRoYE0TvaqQU84OBX8KM1KZUUlq7Fd/mb
         sVB8rjqz0m7qt/lLKfMTdMngFS7t0Cs3r+HGigisXZZJVTfB/J2Uxln/ZSbma92LSjxL
         G++g==
X-Gm-Message-State: AOAM530k4Y8nmlmbrtvrFCgKaG0IGRGPT6E90FZQsHT4ReZO/BK4J0au
        /aD8A0UY8tKh1U3vk96a12FmVA==
X-Google-Smtp-Source: ABdhPJx2XEQW+vlnz4WBQHArLHqV+Fwe3Ix1H14p3IpuTokxVzcUWNZ0wmISRzmPl0gd8Fl92/Br9A==
X-Received: by 2002:a37:8f07:: with SMTP id r7mr10765958qkd.480.1596345948371;
        Sat, 01 Aug 2020 22:25:48 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g129sm16074916qkb.39.2020.08.01.22.25.45
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 01 Aug 2020 22:25:47 -0700 (PDT)
Date:   Sat, 1 Aug 2020 22:25:34 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Down <chris@chrisdown.name>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH mmotm] tmpfs: support 64-bit inums per-sb fix
In-Reply-To: <4d2af3f7-eb4f-6313-1719-b1c532c9a96d@infradead.org>
Message-ID: <alpine.LSU.2.11.2008012218190.13826@eggly.anvils>
References: <cover.1594661218.git.chris@chrisdown.name> <8b23758d0c66b5e2263e08baf9c4b6a7565cbd8f.1594661218.git.chris@chrisdown.name> <alpine.LSU.2.11.2008011223120.10700@eggly.anvils> <alpine.LSU.2.11.2008011928010.13320@eggly.anvils>
 <4d2af3f7-eb4f-6313-1719-b1c532c9a96d@infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 1 Aug 2020, Randy Dunlap wrote:
> On 8/1/20 7:37 PM, Hugh Dickins wrote:
> > Expanded Chris's Documentation and Kconfig help on tmpfs inode64.
> > TMPFS_INODE64 still there, still default N, but writing down its very
> > limited limitation does make me wonder again if we want the option.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> > Andrew, please fold into tmpfs-support-64-bit-inums-per-sb.patch later.
> > 
> > Randy, you're very active on Documentation and linux-next: may I ask you
> > please to try applying this patch to latest, and see if tmpfs.rst comes
> > out looking right to you?  I'm an old dog still stuck in the days of
> 
> Hi Hugh,
> It looks fine.

Thank you so much, Randy.

> 
> > tmpfs.txt, hoping to avoid new tricks for a while.  Thanks!  (Bonus
> > points if you can explain what the "::" on line 122 is about. I started
> > out reading Documentation/doc-guide/sphinx.rst, but... got diverted.
> > Perhaps I should ask Mauro or Jon, but turning for help first to you.)
> 
> That's the correct file. Around line 216, it says:
> 
> * For inserting fixed width text blocks (for code examples, use case
>   examples, etc.), use ``::`` for anything that doesn't really benefit
>   from syntax highlighting, especially short snippets. Use
>   ``.. code-block:: <language>`` for longer code blocks that benefit
>   from highlighting. For a short snippet of code embedded in the text, use \`\`.
> 
> 
> so it's just for a (short) code example block, fixed font...

Bonus points awarded, thanks...ish. I'll have to look around for more
examples of where that's done, and I think it'll only make real sense
to me, when I'm further along, producing the proper output, then seeing
how bad something looks without the "::".

Thanks again,
Hugh
