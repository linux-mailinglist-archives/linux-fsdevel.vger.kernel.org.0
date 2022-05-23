Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590F2531F32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 01:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiEWXYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 19:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiEWXYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 19:24:20 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666076C56A
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 16:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653348258; x=1684884258;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XG5CY2y8Y4b4nY57xIYbeoDM0y2k5T87Yclq6TKJTaw=;
  b=lbO74ATPyeCgcrAS2xUeviuxJN4c4tYXP/q6NgMR/yXM1X5EIysYkXN/
   YkCKbaYPQjLGsLa1vWnUcNoF62dTol+G4c+vScOxVXerB3d0zUHzrIUhA
   vqHj8YmneLGpuK5z4hasvrSAJ+5ItDrH7+Klm9zfPk/4V3we8lIMBcwM6
   wMl/nc8aUEysBaAFvMuF6GNmDLFZRARw8TqIh5k/WsJa6puMA0ImbEvpO
   wxqJfnebCFsB/mhrVs7CQnb4SmtesWuqaukoQWcj+od+aJUw06bI02dA8
   YRgY198p/1988wnqkx1nSjE4bLuoKHIFmaHpSGdBiAEOXlycBn/mLx2Xy
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,247,1647273600"; 
   d="scan'208";a="201220797"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2022 07:24:17 +0800
IronPort-SDR: abYHLxQ76sHKXdSdGVlwum/YqIwFAscNz7AvEpkASLGQwurNJvvledGcpTgYCJtn2Rt8hQaC9w
 T0gU8GLRWPb4tBDBdP+DvwsBUpg+4WFo/7cSOqinohKGfvRH+Yi5dhYxYTEtHn67datWkr9zpw
 2/j18R9hhDa5UWRtmhKCTGHh0CpIiiA91wht6EPKMU0V/H33u3G8cZXvuw2IIju4madGsi5PXN
 VI2SelqNFFZPerxPx47of/urT7g1QC9V1bCC57m64fkifRP2yuIJ1Ui5t0bU5vtQMje4oCECgA
 hVEp1A3a/kZMSgaJ00SZivcD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 May 2022 15:48:15 -0700
IronPort-SDR: cwLmdUxc6oCGEhSmP0YTRIjVHiwU/tkWn2XHNgjmioqiEeg3164LlJJXcPUqsd9DdaJ1dhTs6F
 N3+F27r36pvL7SN7q0rbu+wRvrbc/NUeRvIRnOPj8O4+Mh7SJvZ94VIZLIs6hPkY8i6MZQ54CZ
 9+RBJuYdA4sXPvLZXg8SKlugs0HTUV+ZX89UOJceTfn8Jl716OoR+MhdNgVtFBQWKQR7JoBKdK
 Re8lc/WHH5PoN9nz+dYnBywxmaYDb2I2EvMOu1e3deoxJrnjKOGaEc+6cWaZE0nL493TcvuBtn
 d/A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 May 2022 16:24:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L6YLn0ljSz1Rwrw
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 16:24:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653348256; x=1655940257; bh=XG5CY2y8Y4b4nY57xIYbeoDM0y2k5T87Ycl
        q6TKJTaw=; b=o3BFHA1nMil5Fq3dRSyFnBOdYaOcWE+7Ym4cwmHDbwzH7OCxIQx
        CBsNGz9Yxhxkg/S5HfqDIUiL3rB+rC6hTbcv0g2KeHbhOqDkQC7wOcy0fBGeR4+g
        C30GaeinCQwMZP5NeeoGTMyeGnzrFNXJAYfiT14aSz84Asp0us8uL9Z+Q+v2Dsad
        bidpPSlIDU8nJ1jEKi7nQjDNC0xoBOVzmHwi4LP90FUj+w3QkIQ90W0Qaz1SSDBF
        s5QfCcIwk0jCaKyd7fPAicNCkjSurBSNzOys4ElnbIgZA7m/AmpnVaFscQPSbaxS
        GBFvCpbcZSTxIF9JGYk24yJcFlCV/yNaG1g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L29fcshmgEaP for <linux-fsdevel@vger.kernel.org>;
        Mon, 23 May 2022 16:24:16 -0700 (PDT)
Received: from [10.225.163.54] (unknown [10.225.163.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L6YLl6lMhz1Rvlc;
        Mon, 23 May 2022 16:24:15 -0700 (PDT)
Message-ID: <11272bcd-65e0-ef77-bc9b-5be774f412d5@opensource.wdc.com>
Date:   Tue, 24 May 2022 08:24:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [GIT PULL] zonefs changes for 5.19-rc1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20220523050144.329514-1-damien.lemoal@opensource.wdc.com>
 <CAHk-=wh4zrBLr+2qN+se+F-FKRc9dUfYnv18szvtZiJiVemWOQ@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAHk-=wh4zrBLr+2qN+se+F-FKRc9dUfYnv18szvtZiJiVemWOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/24/22 06:37, Linus Torvalds wrote:
> On Sun, May 22, 2022 at 10:01 PM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> Note: I made a mistake during this PR preparation and inadvertantly deleted the
>> for-5.19 branch used for this PR. I recreated it and prepared the PR using this
>> newly pushed for-5.19 branch. All patches have been in linux-next for a while.
>> I hope this does not trigger any problem on your end.
> 
> Grr.
> 
> That seems to be the cause of repeated commits, which in turn then
> caused conflicts because you had further changes.
> 
> IOW, I already had gotten
> 
>   zonefs: Fix management of open zones
>   zonefs: Clear inode information flags on inode creation
> 
> from the block tree (your commits), and your branch now had different
> copies of those commits.
> 
> And you don't actually list those commits, which makes me think that
> you then did some manual editing of the pull request.

Yes I did. I really messed up. My apologies about that.

> 
> The duplicate commits with identical contents then caused commit
> 87c9ce3ffec9 ("zonefs: Add active seq file accounting") to show as a
> conflict, because the different branches did *some* things the same,
> but then that commit added other changes.
> 
> And honestly, I think that commit is buggy.
> 
> In particular, notice how the locking changes in that commit means
> that zonefs_init_file_inode() now always returns 0, even if
> zonefs_zone_mgmt() failed with an error.
> 
> The error cause it to skip "zonefs_account_active()", but then it
> returns success anyway.
> 
> Was that really intentional?

Absolutely not. That is definitely a bug. Will send a fix for that.
Thank you for catching this.

> 
> I've merged this - with that apparent bug and all - because maybe it
> *was* intentional. But please double-check and confirm that you really
> intended zonefs_init_file_inode() to always return success, unlike the
> old behavior.
> 
>                   Linus


-- 
Damien Le Moal
Western Digital Research
