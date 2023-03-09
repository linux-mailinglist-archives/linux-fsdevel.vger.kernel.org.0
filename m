Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA0B6B28D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 16:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjCIP0p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 10:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjCIP0m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:26:42 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4D66782E;
        Thu,  9 Mar 2023 07:26:40 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C6C485C00EE;
        Thu,  9 Mar 2023 10:26:37 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Thu, 09 Mar 2023 10:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678375597; x=1678461997; bh=C7
        z5cLcHaXzxLy4sG2otzfHSzejEjUVgABGz6xO7/Jc=; b=q6tACLIxf8yXToupR7
        a5THwy1Z1m3hnhDCIgV5ydWMHcQnEFCNt18SscxNjJA94sj4zzBAmHIhg6A5XOko
        XW4AK6zFBvHEH5wsd8koV9NVkvT/2G1OcZC0M9vXIJ4Rhl5z/Kqy5NEcEcR9mtVe
        n1tIwfI1/eENXyyFPd70JvRT4VrosiWQlmUvI6eV8EjtqgGhmJXBaulwST5qVmFg
        DLV4rshhNhZP4KeKV6xxM7Lw84P1OaYJTqdHy6OyrdTBGk/qiwpVCq0YNOo0I6Rq
        5CG8Xw3VNmnKnJvSeo1O35DUgEQef2kc4liOfip/S4Tn9QqHmXdH4mg2QsIIggU0
        h9iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678375597; x=1678461997; bh=C7z5cLcHaXzxL
        y4sG2otzfHSzejEjUVgABGz6xO7/Jc=; b=TESCEzbdQhZnybM1/GQD3HZrn+lwW
        fsRQFubT6ySxCxiFWfnsRGYwY+rObvCIPKZhrk2/IQNcZn3sxpNHY9pGrsrfXnoc
        Ri/PLEsn5roApDk2OIE8koontjRnmPBjT93lAOKGjeYiz7WmYE4T+jL9X5JHCC29
        D6exFUumaSffRKrVKMCD+W8DN1HEytbVi0O6Ci1VZYwQssyM2DkVBHDHxbbOD2+f
        UsCYnraJq4Bh7BB0sNQFtwyokI8Vyf0qDSfqhXl5WvLTnRqyrdpSicuGOh4wAFyl
        lDVwn36OZkqOQSMnpyrrOtZviF2bwMvHeT+FUdVLzyb3QebCDgZO4xqpg==
X-ME-Sender: <xms:rfoJZHiQWYj7e8Sfvnv1yNVdgwmVd5G7KEZWt5JHCcah3cYWSR0gyA>
    <xme:rfoJZEBvhAxd_eDprfgG8o3q9EKebpTsCulLgBuf8I305k3FfUVgfsT8TXN06ctIh
    GDLihl1yVv1gu1e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdduiedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfveho
    lhhinhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeeifeehtdetieeukedvkeehieffffetudefleevtedvleeghfdt
    leffjefghfejveenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkuhgsvghrnhgvth
    gvshdrihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepfigrlhhtvghrshesvhgvrhgsuhhmrdhorhhg
X-ME-Proxy: <xmx:rfoJZHE2t1YgRC4gC0P9bAp-L_S_B3VAzUlvMEvj2oEKbZGv5YnLaQ>
    <xmx:rfoJZEQg-_l-0n13PYaO4_YCFPtzfVdSxcIXFUQY8XskDQED8G5taA>
    <xmx:rfoJZEyZ3QHXK0nSVSSMInA0owqI4VcguOuDpOro82l89qgvY5Q5fg>
    <xmx:rfoJZP8DjvgHyN_svg5GtYR50ClEISH_rEto1QRThZYOPbxXWFD6wA>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 92B672A20080; Thu,  9 Mar 2023 10:26:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-206-g57c8fdedf8-fm-20230227.001-g57c8fded
Mime-Version: 1.0
Message-Id: <b1ec4ce2-1be3-4aaa-9d43-86bcd66b88f0@app.fastmail.com>
In-Reply-To: <CAJfpeguTqXKuBcR3ZBbpWTPTbhnLja0QkBz3ASa4mgaw+A4-rQ@mail.gmail.com>
References: <CAL7ro1GQcs28kT+_2M5JQZoUN6KHYmA85ouiwjj6JU+1=C-q4g@mail.gmail.com>
 <CAJfpeguTqXKuBcR3ZBbpWTPTbhnLja0QkBz3ASa4mgaw+A4-rQ@mail.gmail.com>
Date:   Thu, 09 Mar 2023 10:26:16 -0500
From:   "Colin Walters" <walters@verbum.org>
To:     "Miklos Szeredi" <miklos@szeredi.hu>,
        "Alexander Larsson" <alexl@redhat.com>
Cc:     "Amir Goldstein" <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: WIP: verity support for overlayfs
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Thu, Mar 9, 2023, at 9:59 AM, Miklos Szeredi wrote:
> On Wed, 8 Mar 2023 at 16:29, Alexander Larsson <alexl@redhat.com> wrote:
>>
>> As was recently discussed in the various threads about composefs we
>> want the ability to specify a fs-verity digest for metacopy files,
>> such that the lower file used for the data is guaranteed to have the
>> specified digest.
>>
>> I wrote an initial version of this here:
>>
>>   https://github.com/alexlarsson/linux/tree/overlay-verity
>>
>> I would like some feedback on this approach. Does it make sense?
>>
>> For context, here is the main commit text:
>>
>> This adds support for a new overlay xattr "overlay.verity", which
>> contains a fs-verity digest. This is used for metacopy files, and
>> whenever the lowerdata file is accessed overlayfs can verify that
>> the data file fs-verity digest matches the expected one.
>>
>> By default this is ignored, but if the mount option "verity_policy" is
>> set to "validate" or "require", then all accesses validate any
>> specified digest. If you use "require" it additionally fails to access
>> metacopy file if the verity xattr is missing.
>>
>> The digest is validated during ovl_open() as well as when the lower file
>> is copied up. Additionally the overlay.verity xattr is copied to the
>> upper file during a metacopy operation, in order to later do the validation
>> of the digest when the copy-up happens.
>
> Hmm, so what exactly happens if the file is copied up and then
> modified?  The verification will fail, no?

I believe the intention here is to deploy this without a writable upper dir by default, so there's no copy-up, the calling code just gets -EROFS.  The intention is to also use this to push the podman/docker/kube style ecosystem away from "mutable by default" container images i.e. to "readonlyRootFilesystem" by default (xref https://kubernetes.io/docs/tasks/configure-pod-container/security-context/ )

But yes, some scenarios will still want a writable upper dir for default, as long as that writable upper dir is discarded across reboots (to aid in anti-persistence).  Maybe this needs to be configurable; I could imagine people wanting a writable upper dir, but to still enforce fs-verity for *existing* content.  Other cases may want the logic to just strip away the fsverity xattr across copy-up in this case.
