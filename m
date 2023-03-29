Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8469C6CCF31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 03:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjC2BEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 21:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjC2BEF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 21:04:05 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83045FF
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 18:04:04 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C63835C0143;
        Tue, 28 Mar 2023 21:04:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 28 Mar 2023 21:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1680051841; x=1680138241; bh=8l1z1xprRYeQ3gAOM5OUR5GDV/vNWUDyTva
        U0L+DNXY=; b=MX+CMqKZjTTDqBilEKs4dYZTvBFyi0lnlR68yidC2KB5trwjCZP
        dP6L8uUg2xJZm61wMU4kPLU6Psdq8QVvERIbWmTvP3ttbZ66FwqBnowK3jB0tgEl
        PuQgQmn0eWfNiobkYub0+R9fb2fzzpZzO3EBz1HggTmixQbIwi9vxQF9DuE+WDFd
        SUkgG1KAkLAhAYV2wbewE9ZOsqxWqrlzKOKUvX60y7QiYIBOv3pQTNyXjLqwpNVJ
        oANoG5ukJxO1AU1GF1ldfEukJz5YOfkz+hHA16IxOSM0NU8byWphNkp64Kd3J2H4
        l8z3QakaypfmeSnpWjCmqOC/U6Kk4vPfG4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680051841; x=1680138241; bh=8l1z1xprRYeQ3gAOM5OUR5GDV/vNWUDyTva
        U0L+DNXY=; b=UZRtsbLKj1ICrjJuZghqcnhjxZIdZVZT8lS+H0QqR/gqL1eYNRQ
        +6J3xXCqzqSiVpfvKl1AZByjDE0YiWiaYLrMDOo9bc/Lt1I8m0l5r2DbgH//kwrt
        xCgzaEtuInrXIBSZj3rELepEEXxPo9HdJfeZsGAnEGpntY6ncbN6QdNg8xz0zlbs
        Teu9R6gpi3wt8ZPOap2yihIYeJsv/SkalJPqN2aDgWlDJ1GoG+8NJOIeADASTSSp
        gvmi8GOaMk+7ZkFG8IMG+AOvVT+24JLyjvfnHihk0PGOK5A3ZK9Qd8XPjE1v4C4v
        in++XsKY5azXxBasOG3TqdXAY2RY9tldVkg==
X-ME-Sender: <xms:gY4jZGZ5DXg-UIdSLHLNmWrlzOBqex2wd3Buyvkh0NbieXMj6lFUUw>
    <xme:gY4jZJZwzN68C6JgdB7PfzVY44qjdwwcU1qQ5F6wGBBHFiGfQSyFDysGxESMUCCDi
    zDFLA4aoTzx>
X-ME-Received: <xmr:gY4jZA8M218cQ9wSq1JrCIvG3Syanbm81aCEjLTxLIIBp0j9mWrfFxiPN9qxqL-blM66BQy6NTjCPiDUVVerGzMM0zp2d9UvmqKUGNoNsWZheye2m1_y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehhedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epuefhueeiieejueevkefgiedtteehgfdutdelfffhleeflefhudeuvdefhfeghfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:gY4jZIoI0QE41x5gTRY5919WpKEeGEhhX_BYBZxdoU_dm6zyHZWA3w>
    <xmx:gY4jZBpjKFuHUP2yu452LwJ2-TRAIIEpAccm2iiQ_QenC3Pmw_RyVQ>
    <xmx:gY4jZGQqGoI-E7xBFqSfTwXUAFdy0imhkog1Bvntmx5ShwbbnZfv5g>
    <xmx:gY4jZCSe3zDZ5WaQaCO4vBDzRudFzwNGfP_ZATfwhFj977d8kuIfKQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Mar 2023 21:03:55 -0400 (EDT)
Message-ID: <27b8d5a5-9ab9-c418-ce9c-0faf90677bde@themaw.net>
Date:   Wed, 29 Mar 2023 09:03:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] Legacy mount option "sloppy" support
To:     Karel Zak <kzak@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Steve French <smfrench@gmail.com>,
        Tom Moyer <tom.moyer@canonical.com>,
        Jeff Layton <jlayton@kernel.org>,
        Roberto Bergantinos Corpas <rbergant@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Paulo Alcantara <pc@cjr.nz>,
        Leif Sahlberg <lsahlber@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        NeilBrown <neilb@suse.com>, Steve Dickson <steved@redhat.com>
References: <167963629788.253682.5439077048343743982.stgit@donald.themaw.net>
 <20230328184815.ycgxqen7difgnjt3@ws.net.home>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <20230328184815.ycgxqen7difgnjt3@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29/3/23 02:48, Karel Zak wrote:
> On Fri, Mar 24, 2023 at 01:39:09PM +0800, Ian Kent wrote:
>> Karel do you find what I'm saying is accurate?
>> Do you think we will be able to get rid of the sloppy option over
>> time with the move to use the mount API?
> The question is what we're talking about :-)
>
> For mount(8) and libmount, there is nothing like the "sloppy" mount option.
>
> If you use it in your fstab or as "mount -o sloppy" on the command line,
> then it's used as any other fs-specific mount option; the library copies
> the string to mount(2) or fsconfig(2) syscall. The library has no clue
> what the string means (it's the same as "mount -o foobar").

Which is what the problem really is.


If anyone uses this option with a file system that has previously

allowed it then mounts fail if it isn't handled properly. Then the

intended purpose of it is irrelevant because it causes a fail.


I guess the notion of ignoring it for fsconfig(), assuming it isn't

actually needed for the option handling, might not be a viable idea

... although I haven't actually added that to fsconfig(), I probably

should add that to this series.


But first the question of whether the option is actually needed anymore

by those that allow it needs to be answered.


In case anyone has forgotten it was introduced because, at one time

different OSes supported slightly different options for for the same

thing and one could not include multiple options for the same thing

in automount map entries without causing the mount to fail.


So we also need to answer, is this option conflict still present for

any of the file systems that allow it, currently nfs, cifs and ntfs

(I'll need to look up the ntfs maintainer but lets answer this for

nfs and cifs first).


If it isn't actually needed ignoring it in fsconfig() (a deprecation

warning would be in order) and eventually getting rid of it would be

a good idea, yes?


>
> But there is another "sloppy" :-) The command line argument, "mount -s".
>
> This argument is not internally used by libmount or mount(8), but it's
> repeated on /sbin/mount.<type> command lines (e.g., "mount -t nfs -s"
> means "/sbin/mount.nfs -s").
>
> I guess more interesting is mount.nfs, where both "-s" and "sloppy" lives
> together. The mount.nfs uses this option to be tolerant when parsing mount
> options string, and it also seems it converts "-s" to "sloppy" string for
> mount syscall.

I don't think it makes any difference given the original purpose of

it but hopefully Steve will know/remember.


>
> So, for mount(8)/libmount, digging a grave for the "sloppy" will be trivial.
>
> All I need is to add a note about depreciation to the man page and later
> remove "-s" from /sbin/mount.<type> command line.

Right.


>
> SteveD (in CC:) will comment on it from the NFS point of view because the
> real fun happens there :-)

Yep.


Thanks,

Ian

