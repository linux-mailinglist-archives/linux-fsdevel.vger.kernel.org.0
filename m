Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCB52246E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 01:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgGQXRB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 19:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgGQXRB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:17:01 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A412C0619D2;
        Fri, 17 Jul 2020 16:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ef+sx4FCFDKD8f3Ki+AsdS8ty08ol0udXIqRaW/LotY=; b=fdLx60WrqkoLK0sx3eeSx3fc9N
        3qOh4xfeXZP10F++06CYZ4Rmm7x1bsqctucy8nQ8WuHzDgRtwf1QrjkX5nXQFxK8s/jSL19ljUcla
        p/6ai/LQ2UUMUymEemZ6ZyBXX28cUNa5S1z+bWZsztTRxj23xM4qBz8yoZ19jNphDiDYkZI/1HC4w
        b6TaNVcF5FTAUVCQzjVSZAvJnD35iemwUUiQtlAMTcqNO9wHVp5GrDwkofK6+3qE0bTO4UK+Xy6zQ
        zIROU9XnA9sAsui+cfATf/D/j0ihYFz8ygvjFft8+Yfh4FeHrCJOx74BzXcnF9RaEf2kZrejtgwou
        TkWKdrsQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwZb2-0005Vh-Az; Fri, 17 Jul 2020 23:16:52 +0000
Subject: Re: [RFC PATCH v4 02/12] security: add ipe lsm evaluation loop and
 audit system
To:     Deven Bowers <deven.desai@linux.microsoft.com>, agk@redhat.com,
        axboe@kernel.dk, snitzer@redhat.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, viro@zeniv.linux.org.uk,
        paul@paul-moore.com, eparis@redhat.com, jannh@google.com,
        dm-devel@redhat.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-audit@redhat.com
Cc:     tyhicks@linux.microsoft.com, linux-kernel@vger.kernel.org,
        corbet@lwn.net, sashal@kernel.org,
        jaskarankhurana@linux.microsoft.com, mdsakib@microsoft.com,
        nramas@linux.microsoft.com, pasha.tatshin@soleen.com
References: <20200717230941.1190744-1-deven.desai@linux.microsoft.com>
 <20200717230941.1190744-3-deven.desai@linux.microsoft.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4b0c9925-d163-46a2-bbcb-74deb7446540@infradead.org>
Date:   Fri, 17 Jul 2020 16:16:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200717230941.1190744-3-deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/17/20 4:09 PM, Deven Bowers wrote:
> +config SECURITY_IPE_PERMISSIVE_SWITCH
> +	bool "Enable the ability to switch IPE to permissive mode"
> +	default y
> +	help
> +	  This option enables two ways of switching IPE to permissive mode,
> +	  a sysctl (if enabled), `ipe.enforce`, or a kernel command line
> +	  parameter, `ipe.enforce`. If either of these are set to 0, files

	                                               is set

> +	  will be subject to IPE's policy, audit messages will be logged, but
> +	  the policy will not be enforced.
> +
> +	  If unsure, answer Y.


-- 
~Randy

