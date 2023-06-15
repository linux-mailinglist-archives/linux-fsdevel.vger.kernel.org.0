Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA317314FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 12:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343608AbjFOKPW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 06:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343512AbjFOKPV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:15:21 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97C52710;
        Thu, 15 Jun 2023 03:15:19 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 28C04320095B;
        Thu, 15 Jun 2023 06:15:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 15 Jun 2023 06:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686824113; x=1686910513; bh=jvOa0kUu39x3GQIUZew1mtO2AZHY76muWFu
        JjSogrbo=; b=EPuJmmgzGiJ225PcqtobDHqYGSJ9FbMR2/HM25N5yJWC19vNsWc
        Mc6g6a+7u+xOngvo9ql+gTvTIpzuGWBoP/5w/homxwocEszbS2BY66xEYK6rhU39
        fKC/2J9A/tppqgMokw04lHq9ClAM1NidgPPF8XwPFb8brMaJ+yC9q3lx2oIXOqxk
        NwLzZE/EEO50omOBh8TzBe3YSIduGwMWsqcNQv/QxRuOtVG1aQhGmfZDS7sPfd2L
        ivZT6v6WRn+ar6/Ercj4MGKWKcxqfmYJxSQn9HNqtGrfvghNPb7RO/tPUhDvWwyc
        AMWwvLlS+hTH2y5s8+UvqcROZ9GavRIlJjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1686824113; x=1686910513; bh=jvOa0kUu39x3GQIUZew1mtO2AZHY76muWFu
        JjSogrbo=; b=WQJvt4ZbovTVmVpd9nLF3ZaQUs0YTu6cciUQMWaCHlkUVtF3OXV
        BWs4+jr1+AQmOje/HwT59Uc+gCIA11iaI+HKQgg1BQI7sTScTCZe5aMc5Lf00ImL
        QDpPl/Z5yXuNtNsNhoruSIK8Cot14nLIGVBTkr3kM9F5w/zLjQQXCcCm3wqRDJm2
        HeWiDlna/Wo0l7rNZ01teWvAvYCqAbsjWmH0BfmI4FUBZcNogxXmZuNoaQmWIcoC
        YVUfDU4KdHqT7PrUPo6RaUGRnMnVFM5UYZZEwh9IGjmkuLSVwVR7KWHfNcqZIgQY
        s3tbtsbhHV1NfiIcQHLDi22Z7h98FbB3k5w==
X-ME-Sender: <xms:ruSKZG5KTXG0gmtGtJo7uRZjEP9L2uA8FceNvEHEUY_HEFxS_vSg6w>
    <xme:ruSKZP6gJfjPCPkDZxO7P2yfKxqgVshVYIO-BFUqG9gza_kFyrirnLzCAdWBYHHOA
    rtssRT4dgHj>
X-ME-Received: <xmr:ruSKZFcYMhzp3p4dVxc0s3Vl51XeTu7AHuu5VgqpTZEpWG00hrQLFYFShS57T4NXamlitnOlpunBaAkLolifmc7XM9J10LAESfQWDhF-ssSeVx6A_CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epueegveehueejjedvgeeiheekueduhffgueejgfevgedujeeiieegteehkeehvdeknecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:ruSKZDLzSSqLt02FBEIUzHHY4xZZ_TZ_PWC8bGUEs42QZiREyLJTGA>
    <xmx:ruSKZKI8VzziHd8Su9M3RxLVJW6wU6YgqTLPVAMD4bEXZRsXqShSfg>
    <xmx:ruSKZEz53POS86abZ0ETHQjNStkncFA38huo4bMy2_h8V5Cw8AqPbg>
    <xmx:seSKZBjFa-W9fp3GjiPZn6ETCEsVPgY-xM4OpQEnsiOh_w7YUlORjg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jun 2023 06:14:59 -0400 (EDT)
Message-ID: <ebad4167-6fec-b603-9be8-54457b2a32fd@themaw.net>
Date:   Thu, 15 Jun 2023 18:14:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: (subset) [PATCH v2 3/8] autofs: set ctime as well when mtime
 changes on a dir
To:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Suren Baghdasaryan <surenb@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        autofs@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org
References: <20230612104524.17058-1-jlayton@kernel.org>
 <20230612104524.17058-4-jlayton@kernel.org>
 <20230614-marmeladen-blechnapf-873c26e176cb@brauner>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <20230614-marmeladen-blechnapf-873c26e176cb@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14/6/23 16:30, Christian Brauner wrote:
> On Mon, 12 Jun 2023 06:45:19 -0400, Jeff Layton wrote:
>> When adding entries to a directory, POSIX generally requires that the
>> ctime also be updated alongside the mtime.
>>
>>
> Can't find a tree for this patch, so picking this patch up unless told otherwise.

There's relatively few changes to autofs and Linus asked me to send

changes via. Al or Andrew so there's no point in maintaining a tree

anyway.


Ian

>
> ---
>
> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
>
> [3/8] autofs: set ctime as well when mtime changes on a dir
>        https://git.kernel.org/vfs/vfs/c/9b37b3342a98
