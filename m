Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB3660BF2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 02:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiJYAD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 20:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiJYADH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:03:07 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEB01211E3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 15:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666649897; x=1698185897;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AUarYESSBWuIiRFqSp6O0q+qq8tkbufoEKVSVje4Iy4=;
  b=VcwYiR0ElfCK8nMT10aUCYQ8Ft1ExXMqIdmJTlr57bPV8WAALNgBLqgt
   uDdCiOKPa1Diu48RuCbAcINp9t4qBu0cFrVdMFesCv0+94LiODm4i13Bm
   vctTgYx3eg9jSZNEfhwwkyJ5mf5WXUJQ3ABwefQFACvznCyKDhGlJz5Ls
   zcpC0xoodzEINyAYbeavyNZ93+IbAtox6LVR9bbsw6GlTAEr6JyJk++sJ
   OxRlNC45PEMS03L0mbtSJROnvCtO7wINvi2zrkGaVbgc+qUxWCm7RJ5BL
   6ov9TSA2dzHSWPrJECCIbknA5LXuls6PtbRsNr0Y+bUqBvGm/IJqSp9Y3
   A==;
X-IronPort-AV: E=Sophos;i="5.95,210,1661788800"; 
   d="scan'208";a="215002398"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2022 06:18:10 +0800
IronPort-SDR: uhqc2Lh99SR0si3RFV1+HBhoahMLArHXtFZiy+1C9LlZcnejUzQMKU6vITz4TM3HHecWx14goW
 giWXYo7ZktaoRmiE6kzCfVQv4yQMhSTFhfrzITrgBqUpgF2wFiyqn2YZGeHk6cgC9oR9dLeolZ
 d8LImUoo+2HTCE1/Zdnm2hfXTRYcO76BJF+xxEIQGlmYP84PUw/yQO0y7+TFprWB0lK1wCz77V
 m9OJr29524GHtG4lXG/eqtHzvj55ADecaqduYqLdXrYHozajyyHQ9KHoQxuwgw3n1GjYh74nJD
 EUml7WltJYFpljNDRiT9FxR2
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Oct 2022 14:37:33 -0700
IronPort-SDR: /yD3jwOfqT6tI01xLX3R+eC+1wMimGELVhjKAKcFldwvLO/1yPbGfRSrybO8Dedb18vKhEPi+r
 noOoC2l2HVYls2XbVjyHLblJnPwwb8P1AlW+PCNjsLrWOjlpib1KQyTirrI44JsobgdNULswIy
 /0f+62yftM2HvSnsaqQSiz5Yw0cqbPGxkv0ugaWaDgIddh6oh5BcxqqbJy2iA2DuHDnSk7DheO
 bCZjjrLLIlEw7ZisHf2QlUc+RqqnNmjEfktoTc7cA+eutQwGDveTMMJCVtphqBD/I+3/CBrVTr
 VZ4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Oct 2022 15:18:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mx8bP2r5mz1Rwtl
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 15:18:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666649887; x=1669241888; bh=AUarYESSBWuIiRFqSp6O0q+qq8tkbufoEKV
        SVje4Iy4=; b=BTeM4sx7WaD0/FqfkAJRiv0MyL3ZRUYeQb/taFA/KB+vQgBAtIA
        Da8KBEeBLXmq+uy1X63DEtBHcRkjUcJ3LZZ2YmoM5B4rj/QXA7otcJhf06y/n4/W
        tlTwjJ9NgybBLNM5g0PKKdUtA7OO64fmuz7ce8X8tmJ4kRL/VB0Me4GExSwJZEJF
        wxG1j/Fqz9UJzLXyHdOd0o/a0XXu4NuLLM3dvP0SJrDnSF+2VxnIY7tHFwVIjH7+
        r+dHxcRpHIWa8MnpMSBXeu5QwsfP6cnri5or5CLaAAsTkoqOibM8nQvryUuU5TiL
        WSCnh9OHblbFkntY85LMJgszkd6nmLxQrig==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DK-XkbDD68b6 for <linux-fsdevel@vger.kernel.org>;
        Mon, 24 Oct 2022 15:18:07 -0700 (PDT)
Received: from [10.225.163.8] (unknown [10.225.163.8])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mx8bK1bjpz1RvLy;
        Mon, 24 Oct 2022 15:18:04 -0700 (PDT)
Message-ID: <94ba6a25-b67f-4530-5236-63764711c4d5@opensource.wdc.com>
Date:   Tue, 25 Oct 2022 07:18:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
Content-Language: en-US
To:     Chris Mason <clm@meta.com>, dsterba@suse.cz
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20220901074216.1849941-1-hch@lst.de>
 <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
 <20221024144411.GA25172@lst.de>
 <773539e2-b5f1-8386-aa2a-96086f198bf8@meta.com>
 <20221024171042.GF5824@suse.cz>
 <891da9bf-f703-0ddb-15e8-74647da297ea@meta.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <891da9bf-f703-0ddb-15e8-74647da297ea@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/25/22 02:34, Chris Mason wrote:
> On 10/24/22 1:10 PM, David Sterba wrote:
>> On Mon, Oct 24, 2022 at 11:25:04AM -0400, Chris Mason wrote:
>>> On 10/24/22 10:44 AM, Christoph Hellwig wrote:
>>>> On Mon, Oct 24, 2022 at 08:12:29AM +0000, Johannes Thumshirn wrote:
>>>>> David, what's your plan to progress with this series?
>>>>
>>>> FYI, I object to merging any of my code into btrfs without a proper
>>>> copyright notice, and I also need to find some time to remove my
>>>> previous significant changes given that the btrfs maintainer
>>>> refuses to take the proper and legally required copyright notice.
>>>>
>>>> So don't waste any of your time on this.
>>>
>>> Christoph's request is well within the norms for the kernel, given that
>>> he's making substantial changes to these files.  I talked this over with
>>> GregKH, who pointed me at:
>>>
>>> https://www.linuxfoundation.org/blog/blog/copyright-notices-in-open-source-software-projects
>>>
>>> Even if we'd taken up some of the other policies suggested by this doc,
>>> I'd still defer to preferences of developers who have made significant
>>> changes.
>>
>> I've asked for recommendations or best practice similar to the SPDX
>> process. Something that TAB can acknowledge and that is perhaps also
>> consulted with lawyers. And understood within the linux project,
>> not just that some dudes have an argument because it's all clear as mud
>> and people are used to do things differently.
> 
> The LF in general doesn't give legal advice, but the link above does 
> help describe common practices.
> 
> It's up to us to bring in our own lawyers and make decisions about the 
> kinds of changes we're willing to accept.  We could ask the TAB (btw, 
> I'm no longer on the TAB) to weigh in, but I think we'll find the normal 
> variety of answers based on subsystem.
> 
> It's also up to contributors to decide on what kinds of requirements 
> they want to place on continued participation.  Individuals and 
> corporations have their own preferences based on advice from their 
> lawyers, and as long as the change is significant, I think we can and 
> should honor their wishes.
> 
> Does this mean going through and retroactively adding copyright lines? 
> I'd really rather not.  If a major contributor comes in and shows a long 
> list of commits and asks for a copyright line, I personally would say yes.

I am not aware of any long list of copyright holders in kernel source code
files. I personally thought that the most common practice is to add a
copyright notice for the creator (or his/her employer) of a new source
file, or if for someone who almost completely rewrite a file. That is I
think perfectly acceptable, as adding a new file generally means that a
contribution is substantial.

> 
>>
>> The link from linux foundation blog is nice but unless this is codified
>> into the process it's just somebody's blog post. Also there's a paragraph
>> about "Why not list every copyright holder?" that covers several points
>> why I don't want to do that.
> 
> I'm also happy to gather advice about following the suggestions in the 
> LF post.  I understand your concerns about listing every copyright 
> holder, but I don't think this has been a major problem in the kernel in 
> general.
> 
>>
>> But, if TAB says so I will do, perhaps spending hours of unproductive
>> time looking up the whole history of contributors and adding year, name,
>> company whatever to files.
> 
> I can't imagine anyone asking you to spend time this way.
> 
> -chris
> 

-- 
Damien Le Moal
Western Digital Research

