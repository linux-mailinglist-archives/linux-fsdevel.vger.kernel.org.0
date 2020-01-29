Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2963214CDEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 17:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgA2QDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 11:03:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgA2QDE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=up63fpfGYOvkp3SBYBCK24upbKtaXQK6d7PtLy0cev8=; b=ZdO1rpUQOR0SM6EoYPZcn4JDT
        rNZ3sHm8mZrDvYiY5E3OQPXSNDtuzvvyYWMTEfJJZm7ouV0Pfkxt0A5w5clE3nTH9HCbHEx86BBtp
        6juLb2UL5QT61MbPuGdmvcU/tcfri/3PyajzJEp4x/xWLGljUIFmn8Nbh9jSYIgvZPMeSteD03SRw
        XYVnL8Ln47CE0D+Gws6DTVw/6tlYFzTf2p7maGQN02vRE6V+Yvb02p2UIYDlWoPVTPRMbx//gBNSU
        kcgzWSPUmFGN/EOY7lygHL3FaH5qWjL6DuOx//Gd9S2BC8EuEpH9DWXQ/4igwg3lKKFEeFt3kDOEM
        1D+RgIX9g==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwpnv-0007TM-3C; Wed, 29 Jan 2020 16:02:59 +0000
Subject: Re: mmotm 2020-01-28-20-05 uploaded (security/security.c)
To:     Paul Moore <paul@paul-moore.com>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <20200129040640.6PNuz0vcp%akpm@linux-foundation.org>
 <56177bc4-441d-36f4-fe73-4e86edf02899@infradead.org>
 <CAHC9VhRW68ccE_8HJnv4anFdSgkY2Yk3612LPCT5o4+vXQGqQA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <30511826-765f-6b10-7bad-b950b3941295@infradead.org>
Date:   Wed, 29 Jan 2020 08:02:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRW68ccE_8HJnv4anFdSgkY2Yk3612LPCT5o4+vXQGqQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/29/20 5:51 AM, Paul Moore wrote:
> On Tue, Jan 28, 2020 at 11:52 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 1/28/20 8:06 PM, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2020-01-28-20-05 has been uploaded to
>>>
>>>    http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> mmotm-readme.txt says
>>>
>>> README for mm-of-the-moment:
>>>
>>> http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>> more than once a week.
>>>
>>
>> security/security.c contains duplicate lines for <lockdown_reasons> array:
> 
> Hmmm.  Commit 59438b46471a ("security,lockdown,selinux: implement
> SELinux lockdown"), which was merged into Linus' tree during the
> current merge window, moved the lockdown_reasons array from
> security/lockdown/lockdown.c to security/security.c; is there another
> tree in linux-next which is moving lockdown_reasons into
> security/security.c?
> 

Somehow in mmotm those lines of code were merged 2x:
once from origin.patch and once from linux-next.patch.

Looks more like a mmotm merge issue, not a security/ issue.

-- 
~Randy

