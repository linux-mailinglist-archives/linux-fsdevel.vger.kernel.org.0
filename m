Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B6977B836
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 14:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjHNMHg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 08:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbjHNMHU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:07:20 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A537DDD;
        Mon, 14 Aug 2023 05:07:17 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0A6893200488;
        Mon, 14 Aug 2023 08:07:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 14 Aug 2023 08:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1692014833; x=1692101233; bh=L8+vkE0u6iFHRBlf+qFpYNc+XMstyZCiZPB
        YIihO2vs=; b=kNSZW46YhNFRnaT+Xo+E+3RHxZS+eoGCB03U32kzcaTFoiTZc/W
        MIv2QIlvRaGft2D/bvHd8+8HwtT2NcHB3fPkFh69bCaDlEhEvUMh7WljeuFVugqZ
        tToEAlgXLbhThX/qxcxThpU499FwigwGGmbVIYpC4FlTqvlLevqTvRmvPGw2QSvT
        dQ1LDqfxuosp5kaVlSWAtV8xKQcTGDynfDf2bu1ovE8s4VCJycKM47Buhy0Wq4VN
        EIZkoh64Yef0bNmZYuw3zB6cNz+tCtMDMlMaxMrIRjI2WQI8hTRpk4ywMl5RMytb
        FX1Zf/TvFRPJdJNeAp+27BDSsOMAsctr2Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1692014833; x=1692101233; bh=L8+vkE0u6iFHRBlf+qFpYNc+XMstyZCiZPB
        YIihO2vs=; b=zel/jxTtvBqEdl1YsJU5i5TXefLo2wGi2dwJjp/2b1ZZPAhC88X
        wLtYyw05/TM2E4vffuc6NvA2+v4x+Ovvi41e/2d0DMDGPMxqUmU4u/jEEVubg1GB
        d0HclhAd0n7xl4fHaOjh0DbtOFAImzwUPj+5HF/wgLz3fpOllUSV0rp27orMpNXi
        lQK3JQy5WVz3dM8dUieyZaAJlBjdY1iRlOAB7LGC8BrNF2lFVBMd55fS4jr9Z784
        F9JJOLbYoFZsUf2MbC5Acd+NqRhXUxIHcSslQAPL6vxA4Ogx7RbntJLSIvNnUHkx
        CEJEM+LPwZEiUVK6YUDYa8V2Hz+imdUxuPg==
X-ME-Sender: <xms:8BjaZF-QGSoZNSdFS8CCwSa-uI15sKk-WLQ3u_4H7PCwT3v1o38hAg>
    <xme:8BjaZJvuIaZUW-paWkll46ZFlhtqYAuWIza7gnf4tKPMAgJHkzp3QtPEuEcB7G8_f
    5X5Ic0dIvnOphsL>
X-ME-Received: <xmr:8BjaZDAyFpHE6WtCIqH4LsDR_vFhJ3NERJPDL7f8my65VpFysb2rs4gS5tUkbDfcuqqqLUtneSn2B1skD5_IhIizXiGK1RNrzQrH49szpjSAj17RsbyC1WbW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtgedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepfffhtddvveeivdduuedujeetffekkeelgfdv
    fefgueffieefjefgjeffhedttdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:8BjaZJfqreAunIo0ZkmHG3gi-3lhBcaiYHCIpzOz1Llk8mH1LMM_8w>
    <xmx:8BjaZKNQSFxcwQSuXL30PETDDX9qfhgczXE8A6Do2twX-WRjo5cJwQ>
    <xmx:8BjaZLljZ3RrF-J1wNINoQroTtmGGKvnK4maGfoCxLldvhPlkf3Ejw>
    <xmx:8RjaZB0IhKImZAFrm_9iY9DNUny9tTyA4puWXz7QanFy2M0r8d33hA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Aug 2023 08:07:10 -0400 (EDT)
Message-ID: <da17987a-b096-9ebb-f058-8eb91f15b560@fastmail.fm>
Date:   Mon, 14 Aug 2023 14:07:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [REGRESSION] fuse: execve() fails with ETXTBSY due to async
 fuse_flush
To:     Miklos Szeredi <miklos@szeredi.hu>,
        =?UTF-8?Q?J=c3=bcrg_Billeter?= <j@bitron.ch>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
References: <4f66cded234462964899f2a661750d6798a57ec0.camel@bitron.ch>
 <CAJfpeguG4f4S-pq+_EXHxfB63mbof-VnaOy-7a-7seWLMj_xyQ@mail.gmail.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpeguG4f4S-pq+_EXHxfB63mbof-VnaOy-7a-7seWLMj_xyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/14/23 13:02, Miklos Szeredi wrote:
> On Mon, 14 Aug 2023 at 08:03, Jürg Billeter <j@bitron.ch> wrote:
>>
>> Since v6.3-rc1 commit 5a8bee63b1 ("fuse: in fuse_flush only wait if
>> someone wants the return code") `fput()` is called asynchronously if a
>> file is closed as part of a process exiting, i.e., if there was no
>> explicit `close()` before exit.
>>
>> If the file was open for writing, also `put_write_access()` is called
>> asynchronously as part of the async `fput()`.
>>
>> If that newly written file is an executable, attempting to `execve()`
>> the new file can fail with `ETXTBSY` if it's called after the writer
>> process exited but before the async `fput()` has run.
> 
> Thanks for the report.
> 
> At this point, I think it would be best to revert the original patch,
> since only v6.4 has it.
> 
> The original fix was already a workaround, and I don't see a clear
> path forward in this direction.  We need to see if there's better
> direction.
> 
> Ideas?

Is there a good reason to flush O_RDONLY?


fuse: Avoid flush for O_RDONLY

From: Bernd Schubert <bschubert@ddn.com>

A file opened in read-only moded does not have data to be
flushed, so no need to send flush at all.

This also mitigates -EBUSY for executables, which is due to
async flush with commit 5a8bee63b1.

Fixes: 5a8bee63b1 (unless executable opened in rw)
Signed-off-by: Bernd Schubert <bschubert@ddn.com>


index 89d97f6188e0..e058a6af6751 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -545,7 +545,8 @@ static int fuse_flush(struct file *file, fl_owner_t id)
         if (fuse_is_bad(inode))
                 return -EIO;
  
-       if (ff->open_flags & FOPEN_NOFLUSH && !fm->fc->writeback_cache)
+       if ((ff->open_flags & FOPEN_NOFLUSH && !fm->fc->writeback_cache) ||
+           ((file->f_flags & O_ACCMODE) == O_RDONLY))
                 return 0;
  
         fa = kzalloc(sizeof(*fa), GFP_KERNEL);



