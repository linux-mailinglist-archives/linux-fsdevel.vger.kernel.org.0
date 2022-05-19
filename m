Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF3552DEA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 22:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244795AbiESUra (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 16:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244808AbiESUrU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 16:47:20 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD82C326C2;
        Thu, 19 May 2022 13:47:17 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 436F15C0124;
        Thu, 19 May 2022 16:47:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 19 May 2022 16:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1652993235; x=
        1653079635; bh=q5BGjZKz+6FtcEUB2nrwhoMEpxnZ+4GXO7xfwU4XT/U=; b=c
        y4UMVW57Y2WiPsJvtM88JQYGzBVwTpL5Sd/BYg08h4TqjYnQ471CuZMCcX1/mav+
        dREkI4NlvscwSqlDttJAB4eJzzqVbOdjm7fMzazjlOfI+B2VoZDKXmarWRVB1WQ6
        RPHIOGA/tWU2h/MwYF8Oz1AD0IkB5LfccF7OH+jFIefyODr6azc4W5pUJCAQEkqm
        ZSdPR1gzzNroTsrpD4uKGZZ4pVD1zg0DtLsdTXzqP6KCUfoBdW/7ly5t8X+oihmE
        3I2tZ8a1aRAeh93kuSySIZXlFi79BQZqe03rGHhMM/LVVIOHlq/dtr9tZfKARd23
        d75z/F6+ehmxRB+aUAnCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1652993235; x=
        1653079635; bh=q5BGjZKz+6FtcEUB2nrwhoMEpxnZ+4GXO7xfwU4XT/U=; b=S
        a0MTcdopiluf+XV0Nce2eQ9u/XIH3gZalb3mMt0zZztacTFNCGXCUt/RHW5gqV3D
        EMIdcBztcJWJah0RAX2DutEOhVOCih2Ct2Ocm4E5X5ukwEj09znaQfdIf5d71hxy
        WnWF7FQxUtASEg9V5Ow8J6Q2U6T/9nRVDLu2PXLG+hhOHAxWpJXASS7M7/HKPyDj
        wbUd5iKmZPahAxXFRKU0rnlynp6M4qu7THG070elyEOaFmYmAzvnszIJXETknana
        TezfKO6LLLbQGoVwmH+S8dPKORtjpEb75tJlSD9IjYKpc+aS9oJT9zyTqRLfTF0y
        3gurZW9BbrWY72IYE7ldQ==
X-ME-Sender: <xms:0qyGYhNAPfvpjF_UY9oE_pfBughRqZ-fVYKJ6TkHTC0savS-ziSK3w>
    <xme:0qyGYj92H9QoRqChjM1tNn0If-mtbi9XI2ANiPwh0WfurJm6XO5c_NDUZXRQCw0pQ
    sxLQcVCbN_Lo5De>
X-ME-Received: <xmr:0qyGYgRLFjG-6vK-VVbGcA4zPrn06nwQzM-Xd-S_oKgNVEtdjxogu4_bxDtB07a2FxlUBQTU5yei-UgN_mVV5lhCFUIkJ2iZT4OKMXw-kwHdHsSh31JY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedriedugdduhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:0qyGYtv0dtLJ2BLIvDhfTRHX4KOjptmqm07OwG7LxvK-wfU3MDzmQg>
    <xmx:0qyGYpfHylzsjSefjiy-VNwYo5IHBekUI9yaO09-wZtXZcSpJRXcbw>
    <xmx:0qyGYp1BwyO-BHKYgA0LQlp2rBOUUpSnxo-vg69j5_GDCg-96XUgsg>
    <xmx:06yGYiE_NmFvspKDwbk95eHQJn-eK8HpoDQmm3rhMO3GG4hZlDfQTA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 May 2022 16:47:13 -0400 (EDT)
Message-ID: <fb2937b5-1bbf-511f-082f-b3b7fbc65128@fastmail.fm>
Date:   Thu, 19 May 2022 22:47:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [fuse-devel] [PATCH v5 0/3] FUSE: Implement atomic lookup +
 open/create
Content-Language: fr
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Dharmendra Singh <dharamhans87@gmail.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>
References: <20220517100744.26849-1-dharamhans87@gmail.com>
 <CAJfpegsDxsMsyfP4a_5H1q91xFtwcEdu9-WBnzWKwjUSrPNdmw@mail.gmail.com>
 <f3555e3c-06d9-4d19-d3a2-9a2779937e83@ddn.com>
 <CAJfpegsJijCeNZ9ES72e=gDNDisK5itG67GK8xNWRar=HMm6gA@mail.gmail.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegsJijCeNZ9ES72e=gDNDisK5itG67GK8xNWRar=HMm6gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/19/22 20:16, Miklos Szeredi wrote:
> On Thu, 19 May 2022 at 19:42, Bernd Schubert <bschubert@ddn.com> wrote:
> 
>> Can you help me a bit to understand what we should change? I had also
>> already thought to merge CREATE_EXT and OPEN_ATOMIC - so agreed.
>> Shall we make the other cases more visible?
> 
> Make it clear in the code flow if we are using the new request or the
> old; e.g. rename current fuse_atomic_open() to fuse_open_nonatomic()
> and do
> 
> static int fuse_open_atomic(...)
> {
>      ...
>      args.opcode = FUSE_OPEN_ATOMIC;
>      ...
>      err = fuse_simple_request(...);
>      if (err == -ENOSYS)
>          goto fallback;
>      ...
> fallback:
>      return fuse_open_nonatomic();
> }
> 
> static int fuse_atomic_open(...)
> {
>      if (fc->no_open_atomic)
>          return fuse_open_nonatomic();
>      else
>          return fuse_open_atomic();
> }
> 
> Also we can tweak fuse_dentry_revalidate() so it always invalidates
> negative dentries if the new atomic open is available, and possibly
> for positive dentries as well, if the rfc patch makes it.

Thank you, we will try to do it like that during the next day.


Thanks,
Bernd
