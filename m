Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724982C527C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 11:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgKZKwh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 05:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgKZKwh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 05:52:37 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCCDC0613D4;
        Thu, 26 Nov 2020 02:52:36 -0800 (PST)
Received: from zn.tnic (p200300ec2f0c90002c8516e75060f16f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9000:2c85:16e7:5060:f16f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0FFEC1EC04CC;
        Thu, 26 Nov 2020 11:52:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606387955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gh+f2G9BVTaXsm02eIaeO+A/4ozd4r9j8uEGSvgiAKE=;
        b=rzx3Yr1JJvz8OBZzKFtbbPHci3RnxOSPBmvMfCxopZsZ8F0CYZkjf9SsicA3L/AOvXr9DM
        6X8v+Yrh77FhZ5J0PTRsRPAkHVtJI3s/Jodfok2/Xogdub6jqYxr85v8DaWeV0XqFbk4o6
        kgn/oIMPOZbqmpuu98K+UQ4HyeVUuiY=
Date:   Thu, 26 Nov 2020 11:52:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jan Kara <jack@suse.cz>
Cc:     =?utf-8?B?UGF3ZcWC?= Jasiak <pawel@jasiak.xyz>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: PROBLEM: fanotify_mark EFAULT on x86
Message-ID: <20201126105229.GC31565@zn.tnic>
References: <20201101212738.GA16924@gmail.com>
 <20201102122638.GB23988@quack2.suse.cz>
 <20201103211747.GA3688@gmail.com>
 <20201123164622.GJ27294@quack2.suse.cz>
 <20201123224651.GA27809@gmail.com>
 <20201124084507.GA4009@zn.tnic>
 <20201124102033.GA19336@quack2.suse.cz>
 <20201124102814.GE4009@zn.tnic>
 <20201126104827.GA422@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201126104827.GA422@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 26, 2020 at 11:48:27AM +0100, Jan Kara wrote:
> I'd prefer that as well but if nobody pops up, I'll just push this to my
> tree next week and will see what breaks :)

Right. You could send a proper patch and Cc the usual suspects as now it
is buried in some thread which people might not read.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
