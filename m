Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8485D5385F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 18:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbiE3QPx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 12:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiE3QPw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 12:15:52 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284F87B9E7;
        Mon, 30 May 2022 09:15:51 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id A0383256F;
        Mon, 30 May 2022 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1653927318;
        bh=WVScfFbgKJ7NnVp9/hT3NFgxwiqBR7XzkY9mBBs6vfo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ucrFRqDw0YGRJOvm5Jk7A0s+iGDmpEmuoVnjE0rWYVlqN0Eg7YeBZfC7v5SU82S7l
         l7Es7oeRYlm3WwKdEFZn7Khq4cD8hl3LxGTT0/GUnv5m9CV+ZGQpOHyLA5syQKQY5F
         FtexNBAj3qGnOEWyTWgm3V200m86vLc84wrlMAXc=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 30 May 2022 19:15:48 +0300
Message-ID: <d9d51b3f-e59a-1a50-8c11-ff1b2036271d@paragon-software.com>
Date:   Mon, 30 May 2022 19:15:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/3] fs/ntfs3: Refactoring of indx_find function
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <75a1215a-eda2-d0dc-b962-0334356eef7c@paragon-software.com>
 <0f9648cc-66af-077c-88e6-8650fd78f44c@paragon-software.com>
 <20220528000620.GH3923443@dread.disaster.area>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20220528000620.GH3923443@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This was caused by an incorrect account setting in Thunderbird.
Thanks for catching this.

On 5/28/22 03:06, Dave Chinner wrote:
> On Fri, May 27, 2022 at 05:21:03PM +0300, Almaz Alexandrovich wrote:
>> This commit makes function a bit more readable
>>
>> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> 
> This looks wrong. The email is from
> 
>   "From: Almaz Alexandrovich <almaz.alexandrovich@paragon-software.com>"
> 
> So it looks like the S-o-B has the wrong email address in it. All
> the patches have this same problem.
> 
> Cheers,
> 
> Dave.
