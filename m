Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6754C3AFA55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 02:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhFVAw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 20:52:26 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:55719 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229762AbhFVAw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 20:52:26 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8BE6D58093D;
        Mon, 21 Jun 2021 20:50:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 21 Jun 2021 20:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=fm1; bh=9el
        dDyQA++qoFzO7hCTNTbCYp8KItiVM/rYw2DU6q8g=; b=ZM1Y0Avv66T3WGVuick
        vUdnaOf+vbdFr4u50MLDZNef0VtKUjvLoJRvYDI5Iu8Xi3PavbTAoVpnz9VBh92P
        /Ua1jGiJjgp6PZ7kIQ2kLDcpGrGaszoklMISnBqVrdz8/BAQNZyxMNpXtYLA6w/t
        vXmpcD9cYpyhS1IuFSeHGgMYSAWPSCz7V88Xc9FjtXIX1EagGhfuErVvI5BfX8vL
        BNnTKqEPe1QJ0c+riqo07jZQTitFUOsnEyy+Z1dhpqIHvioP81/WL/JNTVrpKpVs
        L1fG6J6Q3WXjcpmGsTB8uQ4Wt9YRE/9zA/wUhzmRA7iBVfUrA4g9e7yY4uILU4wT
        S/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=9eldDy
        QA++qoFzO7hCTNTbCYp8KItiVM/rYw2DU6q8g=; b=ohNed3FJtDIhPEJntkS3nD
        7+3c79cNNvwa7iwIKmE8vF8prSOxHrn6MQpGubSCMezZoobu+mPxUzwpM5XxPTAo
        D/A7vXud4vXvHMzcXUL/dBwdB6MQ8XZNO2ZmmjBIDDVnH1UQpTSTB+90k07lq0H9
        ImG3mhbHrqpFTMtPD9yrPbvb/YZM0DS7q5GT74aoyXpaGCjSV3oR3JcUz0bljy79
        d1hHCTBS0K1fONjInBVJ8IuBHp+CwGlKh6R5cvDwQwm5pXn5lR+w4dI22U3thiJp
        9jUyGqNYBtzUZYbpHRPGXAJHphuOFxS+vq/3/hHVWfjqnlwPiv/9NCttFA4y8l9w
        ==
X-ME-Sender: <xms:wTPRYKtZtJbOuFbH-dJm263_31JAW58FVD1iDsUvV6qzA-vzoLoRwg>
    <xme:wTPRYPfr825cBf4ZE-8XoaoMYvYnMP4wVCC4WcIc0YvDxP61E5JAXqlx3p9maH8N5
    m45oP_faZM8JzVs0iw>
X-ME-Received: <xmr:wTPRYFy67xTi8AZ3XnZ2KYzpop4KEhazwJE9rvwP6wsvGa1lDAFXfhBbQu4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeegtddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflohhshhcu
    vfhrihhplhgvthhtuceojhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgheqnecugg
    ftrfgrthhtvghrnhepteffkefhtdeitdfhteekfffhhfffheetfedujeeftefhjeegleeu
    ffeftdehheffnecuffhomhgrihhnpehoiihlrggsshdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjohhshhesjhhoshhhthhrihhp
    lhgvthhtrdhorhhg
X-ME-Proxy: <xmx:wTPRYFNtNCXasANykjYWT19lgxNPzBDO2AK2qITbz7PL3N0WeVjYTg>
    <xmx:wTPRYK_iUvBN3pk0Go6z3V2JX8hLk78_ZzU6EsG75zDpgN3jhYeC0Q>
    <xmx:wTPRYNVaLget6YQxGxUTmsvErBjefzdgiU_yEwEDTFPv2OWsnOnnbA>
    <xmx:wjPRYNaI26HXRfYEoEv0lrpEnKenDrgy-SzHKwtUfWY6cGRRyqAj93fJdhJEaFuA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jun 2021 20:50:08 -0400 (EDT)
Date:   Mon, 21 Jun 2021 17:50:07 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     David Howells <dhowells@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-cachefs@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: Re: How capacious and well-indexed are ext4, xfs and btrfs
 directories?
Message-ID: <YNEzvwgqo6pQ50Pq@localhost>
References: <206078.1621264018@warthog.procyon.org.uk>
 <6E4DE257-4220-4B5B-B3D0-B67C7BC69BB5@dilger.ca>
 <YKntRtEUoxTEFBOM@localhost>
 <B70B57ED-6F11-45CC-B99F-86BBDE36ACA4@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B70B57ED-6F11-45CC-B99F-86BBDE36ACA4@dilger.ca>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 03:13:52PM -0600, Andreas Dilger wrote:
> There was a patch pushed recently that targets "-o discard" performance:
> https://patchwork.ozlabs.org/project/linux-ext4/list/?series=244091
> that needs a bit more work, but may be worthwhile to test if it improves
> your workload, and help put some weight behind landing it?

I just got a chance to test that patch (using the same storage stack,
with ext4 atop dm-crypt on the same SSD). That patch series makes a
*massive* difference; with that patch series (rebased atop latest
5.13.0-rc7) and the test case from my previous mail, `rm -r testdir`
takes the same amount of time (~17s) whether I have discard enabled or
disabled, and doesn't disrupt the rest of the system.  Without the
patch, that same removal took many minutes, and stalled out the rest of
the system.

Thanks for the reference; I'll follow up to the thread for that patch
with the same information.

- Josh Triplett
