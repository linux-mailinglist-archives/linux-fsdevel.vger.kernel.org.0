Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4553777C27E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 23:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjHNVem (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 17:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjHNVeO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:34:14 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A95611D;
        Mon, 14 Aug 2023 14:34:13 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 59ED73200657;
        Mon, 14 Aug 2023 17:34:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 14 Aug 2023 17:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1692048851; x=1692135251; bh=eEPse9ECRAzn6ElLDhuMktRPeYOzvASO0sc
        0DZKvmYU=; b=TnYi/bbsx2ggn2SGxWnJEQmGzN3OagYR6pyoisWagh4c0+k/yoe
        CFMS2wcVDMoEgemvomHr7DyYNS+RyjzwJKvi7XM+Wq0dSjmLYj0Q/xwSV7Fe27z1
        WXvInKfrtv1HGmaMsVdzncWRpbVWezt5n59obXQ63qNYplMEJEzZlSVPXHPop+9/
        xFS4EtMfxJMQjk0JpT1UFs28ae2dfbzEYL2YgIyfYN8apX/8oGKYSOVoPew0vsBw
        lgmK5ikayUFfl3vX0udYtTpGwJkPFtpgOMBb1yOXNXNUIfmLgpS25y7xWIfWKddN
        TB2FZ39wRIVw8oSiGnF2ih8SVyStbfUeAgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1692048851; x=1692135251; bh=eEPse9ECRAzn6ElLDhuMktRPeYOzvASO0sc
        0DZKvmYU=; b=Yrr2YQxaq9qY7kvHoBRQQZisXd01NX5Huwafc/YT4iQRIBuim9G
        dn0qwX5uHi/4gRrL25XkaJjxLCvEhM1x39HkrmfOW5O854cuYUY9qaW8K0qcN1th
        INo4sBBF6bQjfYxykDpa4mS9znLFdkV5hE/e4db9wk8BcLxGl6Z2hE9weBISdz63
        HBnV9r4zdMT42Nrwull50uhFLElIICkvItjOZHB7lyEORooEQ9u7vSrf+M+hXFfN
        QWpy+daS7YjgtTtQ3q1uwLGuv7S3xTd88O9Q9tBRsG1wwn3XG9M/X5K8BVnPUZtR
        FksX1XEVR8dywg+lG3/kY6hUrBKE9X46Q4Q==
X-ME-Sender: <xms:053aZFK1CnLelYW-AsxXrBnfPlXMd3VThFdmOzo5sa_2TQNh-JBICA>
    <xme:053aZBL8BLn6E10ZDo48uNM6f2UfD82lUUwP8THtIJbi5wIqREYRATxuDAgnuMDe-
    cuCO4mpswylU1qP>
X-ME-Received: <xmr:053aZNvXjzXBCo7sxhbrpXo9QhPHnNuWiG2yvlfm6d8m5RUxLb_ImdptvETHJTGGEVzK38poWAlI_IOui_0WrdBzJ_R8S9EY9l70xGaKbcKTZjqrcovmPauV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddthedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepfffhtddvveeivdduuedujeetffekkeelgfdv
    fefgueffieefjefgjeffhedttdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:053aZGYW9TYmODksSoCZ5sOK4dLiznOw1eMpAw49brxCFwDJJCpvtg>
    <xmx:053aZMbxxe72fqhKJvElzZXlN0wGsFIPyMBxAaIdlrSJdWXyej5Dpw>
    <xmx:053aZKBx7phtuP-TFPuVMsCLcxGvIqx_pc3dOqGRx0XUg03t5J1x1A>
    <xmx:053aZLyaA9f2jkRvWH-qEZBxM93iHhO2oL9bADnCy69MtfCyczk1Qg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Aug 2023 17:34:10 -0400 (EDT)
Message-ID: <c88e4470-c20a-77fd-be19-f8d2e92b5125@fastmail.fm>
Date:   Mon, 14 Aug 2023 23:34:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [REGRESSION] fuse: execve() fails with ETXTBSY due to async
 fuse_flush
Content-Language: en-US, de-DE
To:     Tycho Andersen <tycho@tycho.pizza>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     =?UTF-8?Q?J=c3=bcrg_Billeter?= <j@bitron.ch>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
References: <4f66cded234462964899f2a661750d6798a57ec0.camel@bitron.ch>
 <CAJfpeguG4f4S-pq+_EXHxfB63mbof-VnaOy-7a-7seWLMj_xyQ@mail.gmail.com>
 <ZNozdrtKgTeTaMpX@tycho.pizza>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <ZNozdrtKgTeTaMpX@tycho.pizza>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/14/23 16:00, Tycho Andersen wrote:
> On Mon, Aug 14, 2023 at 01:02:35PM +0200, Miklos Szeredi wrote:
>> On Mon, 14 Aug 2023 at 08:03, Jürg Billeter <j@bitron.ch> wrote:
>>>
>>> Since v6.3-rc1 commit 5a8bee63b1 ("fuse: in fuse_flush only wait if
>>> someone wants the return code") `fput()` is called asynchronously if a
>>> file is closed as part of a process exiting, i.e., if there was no
>>> explicit `close()` before exit.
>>>
>>> If the file was open for writing, also `put_write_access()` is called
>>> asynchronously as part of the async `fput()`.
>>>
>>> If that newly written file is an executable, attempting to `execve()`
>>> the new file can fail with `ETXTBSY` if it's called after the writer
>>> process exited but before the async `fput()` has run.
>>
>> Thanks for the report.
>>
>> At this point, I think it would be best to revert the original patch,
>> since only v6.4 has it.
> 
> I agree.
> 
>> The original fix was already a workaround, and I don't see a clear
>> path forward in this direction.  We need to see if there's better
>> direction.
>>
>> Ideas?
> 
> It seems like we really do need to wait here. I guess that means we
> need some kind of exit-proof wait?


I'm not sure how hackish it is, if fuse_flush gets converted to 
queue_work() and with a new work-queue in struct fuse_inode. That 
work_queue could be flushed through a new inode operation from 
do_open_execat.


Bernd
