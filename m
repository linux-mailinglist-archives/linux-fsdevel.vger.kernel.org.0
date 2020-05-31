Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A3D1E9758
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 May 2020 13:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgEaLoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 May 2020 07:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEaLoh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 May 2020 07:44:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D64EC061A0E
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2020 04:44:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q11so8675581wrp.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2020 04:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PdySI9HRU59giX2TRuouXda7ucg+/Ke1CbnoMbOGJFM=;
        b=LuOvEeextkcLDqBQxJB8nGW1fWsQrMiAX09DS4okshWz75BVS8TlXBBbvJvI8NdLyD
         TWVmyhz/A6xbpskH1Qq9TCxIcjUIooRAunU9Mda0v74PSjT8xwu/ESmGxjW61KwSw0pV
         bn9QPbXYFP+lX6XmPg1hD12I87ncewBugSFsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PdySI9HRU59giX2TRuouXda7ucg+/Ke1CbnoMbOGJFM=;
        b=ppfmidikmXA00Re/e8MmUC3Iay8Vo7Gni4PxvoJst0dgdYAEzGfX+wSgMB1IzW+6ZB
         cBZ5Fp4CXgO3uMm7wbqSCruyzV4TrxXKBvas1Gx5ckReXXnon6vJlHNVhZ3SpgDXbsDH
         Q1Kb0NgbzW6vxCKfqZA3CnS4uPgAlnQdlvQJbl9v02P9G8hE87hH/KA+0db6Czjm8cwR
         2BXoZKRqdCJ29tfbJ3jEHjsrzzyfs9iVpo66Xsbd027HBMn6IuNy7a/lkjR3xxZfsiXF
         emaV1xDE+xcU1kMfYXTN6sv4dI2e1K9Cn0X33NLpGk3Cp8UZpD+IiatPjjh/K9wTlKmX
         D3sQ==
X-Gm-Message-State: AOAM533+HpgmEfoBaubs/LP6Ac1rMFOaZDW2i3onvDu7E4YkZgdxbQW2
        UBk7R/5lDwuVLi2kh+AHS3cl9Q==
X-Google-Smtp-Source: ABdhPJzXwAp4Krf0+AsErSZJFxwLPQq4I1P4wrKXweQgRuYhfV18G1aXcLUbN8ZO7e93F9bjJUy6rQ==
X-Received: by 2002:adf:db47:: with SMTP id f7mr18018839wrj.101.1590925476016;
        Sun, 31 May 2020 04:44:36 -0700 (PDT)
Received: from noodle ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id k64sm5935156wmf.34.2020.05.31.04.44.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2020 04:44:35 -0700 (PDT)
Date:   Sun, 31 May 2020 14:44:32 +0300
From:   Boris Sukholitko <boris.sukholitko@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, keescook@chromium.org,
        yzaikin@google.com
Subject: Re: [PATCH] __register_sysctl_table: do not drop subdir
Message-ID: <20200531114432.GB22327@noodle>
References: <20200527104848.GA7914@nixbox>
 <20200527125805.GI11244@42.do-not-panic.com>
 <20200528080812.GA21974@noodle>
 <874ks02m25.fsf@x220.int.ebiederm.org>
 <20200528142045.GP11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528142045.GP11244@42.do-not-panic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 02:20:45PM +0000, Luis Chamberlain wrote:
> On Thu, May 28, 2020 at 09:04:02AM -0500, Eric W. Biederman wrote:
> > I see some recent (within the last year) fixes to proc_sysctl.c in this
> > area.  Do you have those?  It looks like bridge up and down is stressing
> > this code.  Either those most recent fixes are wrong, your kernel is
> > missing them or this needs some more investigation.
> 
> Thanks for the review Eric.
> 

Seconded. My first try at fixing it was incorrect, hopefully the new
attempt ([PATCH] get_subdir: do not drop new subdir if returning it)
I've just sent will fare better.

> Boris, the elaborate deatils you provided would also be what would be
> needed for a commit log, specially since this is fixing a crash. If
> you confirm this is still present upstream by reproducing with a test
> case it would be wonderful.

Yes. It is present in the upstream kernel. In my patch I've added
warning to catch this bad condition. The warning fires easily during
boot.

Thanks,
Boris.
