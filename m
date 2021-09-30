Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EA241DC6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 16:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350669AbhI3OkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 10:40:00 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:53643 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348440AbhI3OjS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:39:18 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5A9F8580F9A;
        Thu, 30 Sep 2021 10:37:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 30 Sep 2021 10:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=mx+31OMai8gbaIunBA/PcL9q6BG
        p95XY+PT2AgPSDuI=; b=JYAPl8xuiMqjPKgj4D5TmY/fbL5ORVlyC8IMByPJoSf
        rFfBL+JSOjLRSdKL5CxCCD28WWHdKcS8bZLdyvoJhjwKWH6QZC36Q9HENw8S3H77
        6B5Rgt4ZU4WTAV64E2nivZ67w8+8v4Paz5nXCYViB/AyUQKWk4LL3uXMIzKTYdxa
        7+9k0AB3UFf+ffa9LLX4bZO4LAm4UavnOc4TA8kjhJZGsXXAqRvOghy6oouQsE4u
        6RLOrZF/jczhlgtVmGDzW9s6KZTvc3joQP+GcZA7Ym5h3ZbzOBB0I6R1V7+l8o16
        oJ9pRD4b7y1v2wQoKeQAplg3SA7qJgd2iAj7rglptkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=mx+31O
        Mai8gbaIunBA/PcL9q6BGp95XY+PT2AgPSDuI=; b=Hkeiyi6U0uImqNh8Q55Fxq
        5Nry+jvvYAqpMOLpeP4TG0HnSix9czmk62R+t3LeuI5Bv6MySvwi4cf+RYZneYjc
        qrefVFoLOHlnXPM2AB4rdk9IyYKJn68YAtyH1/ZMUWmw/bpx3WBKXoA7cius8Mm4
        FfQMp9tWPexnRflXcF4Sb7yqvNiHssoatzJMX7EEiNfWyAb7v9pRgYy30eZQjLfA
        eWjBtrGfFqqsPHwl9qKRKxe3T9mNOGVIYX036yJ8sOT7DQbBoQ+8I4EZf5WCc1vB
        PwRJLl9toGEyM3Ki6HXQV2BPclPvLwYsIfgLQlGWvIeGvxrmefEn75pjb8H8B7Dg
        ==
X-ME-Sender: <xms:n8tVYZ6NoqwsyUVPSsciMz5l00besVr288mFzIw4Srergzc8szvlbw>
    <xme:n8tVYW5cEGblGsepamYCmpWYkiXDlSqm_gvfFcF2RmyVrNHXSPc9Ui9Xay_NW04-J
    dXZWP9bfdOaqx1vwOU>
X-ME-Received: <xmr:n8tVYQeHyrhpcAwjgmyOlsB5RLUtaS9DThMravEcO9FesdfSmUis3En0IPz9HwofSeARJ_lJvY_wTLTaEwON8omp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekgedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpeffhffvuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepvfihtghhohcutehnuggvrhhsvghnuceothihtghhohesthihtghhoh
    drphhiiiiirgeqnecuggftrfgrthhtvghrnhepffeukeekudejfefhjeevgeejgffhkefh
    ffetleduvddufeekteelkeekhfefudejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigt
    hhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:n8tVYSI043SLp-mQJrY7ZeLX0WxKyvFtInlS5134PNnWyRc107HnTg>
    <xmx:n8tVYdKCL61aT7mZ7jTwLvL67HqH_TN4mvqlcLO31N8jT34r0mujKw>
    <xmx:n8tVYbz7QaM8utHAVyjZo0hpkJ93z2FHR3PHtpcbieOEAyclOBiLdw>
    <xmx:o8tVYXaDZEfAVQibC0xnGAOZQCbAZFQs3K32yigrzQPaHYTn2EKdKw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Sep 2021 10:37:17 -0400 (EDT)
Date:   Thu, 30 Sep 2021 08:37:15 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Tobin C. Harding" <me@tobin.cc>, linux-hardening@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Anand K Mistry <amistry@google.com>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Stefan Metzmacher <metze@samba.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 6/6] leaking_addresses: Always print a trailing newline
Message-ID: <YVXLm5dC3nRKZpF3@cisco>
References: <20210929220218.691419-1-keescook@chromium.org>
 <20210929220218.691419-7-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929220218.691419-7-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 29, 2021 at 03:02:18PM -0700, Kees Cook wrote:
> For files that lack trailing newlines and match a leaking address (e.g.
> wchan[1]), the leaking_addresses.pl report would run together with the
> next line, making things look corrupted.
> 
> Unconditionally remove the newline on input, and write it back out on
> output.
> 
> [1] https://lore.kernel.org/all/20210103142726.GC30643@xsang-OptiPlex-9020/
> 
> Cc: "Tobin C. Harding" <me@tobin.cc>
> Cc: Tycho Andersen <tycho@tycho.pizza>

Acked-by: Tycho Andersen <tycho@tycho.pizza>

Thanks!

> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  scripts/leaking_addresses.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
> index b2d8b8aa2d99..8f636a23bc3f 100755
> --- a/scripts/leaking_addresses.pl
> +++ b/scripts/leaking_addresses.pl
> @@ -455,8 +455,9 @@ sub parse_file
>  
>  	open my $fh, "<", $file or return;
>  	while ( <$fh> ) {
> +		chomp;
>  		if (may_leak_address($_)) {
> -			print $file . ': ' . $_;
> +			printf("$file: $_\n");
>  		}
>  	}
>  	close $fh;
> -- 
> 2.30.2
> 
