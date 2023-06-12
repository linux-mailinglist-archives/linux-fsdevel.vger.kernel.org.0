Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5E072CEC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 20:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbjFLSxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 14:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjFLSxj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:53:39 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3D7E7D;
        Mon, 12 Jun 2023 11:53:37 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5DA7B32007F0;
        Mon, 12 Jun 2023 14:53:34 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Mon, 12 Jun 2023 14:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686596013; x=1686682413; bh=Fz
        apP+yPAKsrmMAHLk6/FoLZakwauFKN0p+TZdurY3c=; b=E2y2hTkOaOcROLFFUe
        ErMsFo7e7/xkgXFLHD8Z8df6RdCElCmCtHsruiNufD674WnxGeOoLvamVifgvoL4
        CUVOHTHCvCTKbOx+IIey8vE7opHByxw2/pX2kzCceEh/m+X4d/smoR9ZBihAhbO1
        jxMI40DP/1vZYV+4Ss2DvL5W0AJUfqYKyy9jLGf/wWfXH4PLkYJZ9vgoVysZMOd1
        lQd8gBuxni/4lpYBndPVyPkxRhDgIUGOVZ4J8+6EgV8e5RMuxiGKIml21bta44V6
        it40aAK9/kuTAHH70V2E2PmIvTKVL0SX8sCiQGYorI1/mCTBDW4gaW334eDOD4XB
        vwPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686596013; x=1686682413; bh=FzapP+yPAKsrm
        MAHLk6/FoLZakwauFKN0p+TZdurY3c=; b=hkji4+Be8qnSijlnvcO9HKn/eLnDP
        sfCnd5zKMVcIfrmtD08tTrRWMZBfBbytk7vjr37Aggnn3dr0lfi3BGT/c7uDcj9t
        Q9dS4qtkmPt1xrAJrNMcRW9VG6rA31S/M7n0fi0gjH3D6adUasN2s04RWwTkgkep
        0YG2tv5/q6A6UEzCeA34knpvH2Yt6WtWxnhlmBQ6dfqc5CP2MRBFg2Z9/awjcYdq
        y4OtPDaZcU/lDiWgFHu70DYrKmc/oAVNFDb491l1hkRSa7EGT+9Lp/kwp5zLJBBp
        ils3gpg12QwQ/DtlBX+zByxNK//TIXIsrEqW2xZd3vFNaczoAH8OBk2oA==
X-ME-Sender: <xms:rWmHZDtdan_w5KUvn4Wr6qWNEj5ydYC5XoVLWuLokldUcoUIa0uSDg>
    <xme:rWmHZEfQZjTetTHxIkcK0bG--k1kAHGRcKOsRdB-fMC6XMuuaSurEUJR_vXMITltd
    BhOvgW8R3n5h-0d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduhedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    ohhlihhnucghrghlthgvrhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqne
    cuggftrfgrthhtvghrnhepffektdfgleeuudevheduueetffejgeefkeeifeekfeetkedu
    jeffveeiudehhfefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifrghlthgvrhhssehvvghr
    sghumhdrohhrgh
X-ME-Proxy: <xmx:rWmHZGzQujmOU2R--5XG-9k_BeEwD1kFSn6wLcnfbDShLJfBv7U31Q>
    <xmx:rWmHZCMyP3z4e4NtRZ2Z3mGSz5j7wZnyS817zPmLcLB29hislWv7AA>
    <xmx:rWmHZD-Pe3zgl-L6NLcUluC1XFbMhKvqCkJ8CdkrUWR4VNk4beV1_g>
    <xmx:rWmHZDyH5ThLRPFoycWFM7gD7HS5_c0NqGc97qdMqxg0KQrjt5RJBg>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 70DC62A20080; Mon, 12 Jun 2023 14:53:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-492-g08e3be04ba-fm-20230607.003-g08e3be04
Mime-Version: 1.0
Message-Id: <a6c355f7-8c60-4aab-8f0c-5c6310f9c2a8@betaapp.fastmail.com>
In-Reply-To: <2f629dc3-fe39-624f-a2fe-d29eee1d2b82@acm.org>
References: <20230612161614.10302-1-jack@suse.cz>
 <20230612162545.frpr3oqlqydsksle@quack3>
 <2f629dc3-fe39-624f-a2fe-d29eee1d2b82@acm.org>
Date:   Mon, 12 Jun 2023 14:52:54 -0400
From:   "Colin Walters" <walters@verbum.org>
To:     "Bart Van Assche" <bvanassche@acm.org>, "Jan Kara" <jack@suse.cz>,
        "Jens Axboe" <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        "Christoph Hellwig" <hch@infradead.org>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>, yebin <yebin@huaweicloud.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted devices
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Mon, Jun 12, 2023, at 1:39 PM, Bart Van Assche wrote:
> On 6/12/23 09:25, Jan Kara wrote:
>> On Mon 12-06-23 18:16:14, Jan Kara wrote:
>>> Writing to mounted devices is dangerous and can lead to filesystem
>>> corruption as well as crashes. Furthermore syzbot comes with more and
>>> more involved examples how to corrupt block device under a mounted
>>> filesystem leading to kernel crashes and reports we can do nothing
>>> about. Add config option to disallow writing to mounted (exclusively
>>> open) block devices. Syzbot can use this option to avoid uninteresting
>>> crashes. Also users whose userspace setup does not need writing to
>>> mounted block devices can set this config option for hardening.
>>>
>>> Link: https://lore.kernel.org/all/60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org
>>> Signed-off-by: Jan Kara <jack@suse.cz>
>> 
>> Please disregard this patch. I had uncommited fixups in my tree. I'll send
>> fixed version shortly. I'm sorry for the noise.
>
> Have alternatives been configured to making this functionality configurable
> at build time only? How about a kernel command line parameter instead of a
> config option?

It's not just syzbot here; at least once in my life I accidentally did `dd if=/path/to/foo.iso of=/dev/sda` when `/dev/sda` was my booted disk and not the target USB device.  I know I'm not alone =)

There's a lot of similar accidental-damage protection from this.  Another stronger argument here is that if one has a security policy that restricts access to filesystem level objects, if a process can somehow write to a mounted block device, it effectively subverts all of those controls. 

Right now it looks to me we're invoking devcgroup_check_permission pretty early on; maybe we could extend the device cgroup stuff to have a new check for write-mounted, like

```
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c994ff5b157c..f2af33c5acc1 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6797,6 +6797,7 @@ enum {
 	BPF_DEVCG_ACC_MKNOD	= (1ULL << 0),
 	BPF_DEVCG_ACC_READ	= (1ULL << 1),
 	BPF_DEVCG_ACC_WRITE	= (1ULL << 2),
+	BPF_DEVCG_ACC_WRITE_MOUNTED	= (1ULL << 3),
 };
 
 enum {
```

?  But probably this would need to be some kind of opt-in flag to avoid breaking existing bpf progs?

If it was configurable via the device cgroup, then it's completely flexible from userspace; most specifically including supporting some specially privileged processes from doing it if necessary.

Also, I wonder if we should also support restricting *reads* from mounted block devices?
