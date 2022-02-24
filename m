Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6B04C2E89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 15:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbiBXOiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 09:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbiBXOiS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:38:18 -0500
X-Greylist: delayed 909 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Feb 2022 06:37:44 PST
Received: from matoro.tk (unknown [IPv6:2600:1700:4b10:9d80::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137329D0C2;
        Thu, 24 Feb 2022 06:37:42 -0800 (PST)
DKIM-Signature: a=rsa-sha256; bh=U1Serj9HWMW/oXYgmC1Rsp6t8gZrl/v31HBeiGDPdW4=;
 c=relaxed/relaxed; d=matoro.tk;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@matoro.tk; s=20220111215046; t=1645712524; v=1; x=1646144524;
 b=OYghG0ZP+iuW2kkTQeOuixHFPq878+wQ3HhdKX/+sGY09GTDTQFDIubVowj2KCUAMa6hGg5z
 emJxwo7k7iwM+JXu+3yE3DQsx9HG4ZBJFjS7BSFq9MSKfoo49MhkWqwuAJEne4d1p2n+MK3w3H8
 nhuIW5JuvEJLWhiNLUwOESPgCTRpscLtEwNsfWc0aDp2LixMpHlSmIO3VnR7RTqooKC9CJ452ta
 UM/qxfqM6Nlt5xE5jAS8lL/ueEDBCRO0qXA1nFOqZlgmtbsnnC34+1V9rWsHe+kOSZvMMUBiJFB
 K4HJAmTDISfkfJWq4HoGTEVo0ctw8pdW/tc5RR+gFhe9y5izzW0GcfFP8gvPREsJRbIYTHEZveH
 NJIUWtL5448BOMyUyVZJd8eXKj7O6wIfQYM5zT+W6lbbIGrxx6rNVZYEZmPnkite3l2zZVqeykW
 dCiw9yfIpH+X2yA4GZY9Gcn3xQzZozeYYlW/Q97jERXi6XkljbaZD4a3xtRGCiHv3oNAuM+Dq7w
 wbitZLVe9+B/0pgWjr3tva2lqhvnaBM4DX13iSpzOlTQPjc59ofE0WA1pB734Psd/WzIez+xhhJ
 5uI3scCkVBLSXtxRDzqLthxm5AUzUYmDZ28l+DVLASRcTR9KsEqNWlrE/Qss9Etj2UT9EQdVjTg
 RrbyoJjcB0U=
Received: by matoro.tk (envelope-sender
 <matoro_mailinglist_kernel@matoro.tk>) with ESMTPS id f168343e; Thu, 24 Feb
 2022 09:22:04 -0500
MIME-Version: 1.0
Date:   Thu, 24 Feb 2022 09:22:04 -0500
From:   matoro <matoro_mailinglist_kernel@matoro.tk>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        matoro_bugzilla_kernel@matoro.tk,
        Andrew Morton <akpm@linux-foundation.org>,
        regressions@lists.linux.dev, linux-ia64@vger.kernel.org,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: regression: Bug 215601 - gcc segv at startup on ia64
In-Reply-To: <7e3a93e7-1300-8460-30fb-789180a745eb@physik.fu-berlin.de>
References: <a3edd529-c42d-3b09-135c-7e98a15b150f@leemhuis.info>
 <823f70be-7661-0195-7c97-65673dc7c12a@leemhuis.info>
 <03497313-A472-4152-BD28-41C35E4E824E@chromium.org>
 <94c3be49-0262-c613-e5f5-49b536985dde@physik.fu-berlin.de>
 <9A1F30F8-3DE2-4075-B103-81D891773246@chromium.org>
 <4e42e754-d87e-5f6b-90db-39b4700ee0f1@physik.fu-berlin.de>
 <202202232030.B408F0E895@keescook>
 <7e3a93e7-1300-8460-30fb-789180a745eb@physik.fu-berlin.de>
Message-ID: <65ed8ab4fad779fadf572fb737dfb789@matoro.tk>
X-Sender: matoro_mailinglist_kernel@matoro.tk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kees, I can provide live ssh access to my system exhibiting the 
issue.  My system is a lot more stable due to using openrc rather than 
systemd, for me GCC seems to be the only binary affected.  Would that be 
helpful?

On 2022-02-24 04:33, John Paul Adrian Glaubitz wrote:
> Hi Kees!
> 
> On 2/24/22 06:16, Kees Cook wrote:
>>> You should be able to extract the binaries from this initrd image and 
>>> the "mount" command,
>>> for example, should be one of the affected binaries.
>> 
>> In dmesg, do you see any of these reports?
>> 
>>                 pr_info("%d (%s): Uhuuh, elf segment at %px requested 
>> but the memory is mapped already\n",
>>                         task_pid_nr(current), current->comm, (void 
>> *)addr);
> 
> I'll check that.
> 
>> I don't see anything out of order in the "mount" binary from the above
>> initrd. What does "readelf -lW" show for the GCC you're seeing 
>> failures
>> on?
> 
> I'm not 100% sure whether it's the mount binary that is affected. What
> happens is that once init takes over,
> I'm seeing multiple "Segmentation Fault" message on the console until
> I'm dropped to the initrd shell.
> 
> I can check what dmesg says.
> 
> Adrian
