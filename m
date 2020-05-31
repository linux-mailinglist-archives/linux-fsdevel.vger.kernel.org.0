Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C521E9756
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 May 2020 13:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgEaLjn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 May 2020 07:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEaLjm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 May 2020 07:39:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D36EC061A0E
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2020 04:39:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l10so8590172wrr.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2020 04:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F2pFMV2RQXtj7Yzz6U7H9/qhPmhQ/n2kJAXbFxzQZss=;
        b=S0jBzsfTnWu0/30NzJprySQKl2NMrq3hjZpFFvo2E74a6p+LyPJ68+0zTDwPSWrC9G
         77cVKpG4+KaCGL32BCqa+94jcmsHXR2uIPNWtjsMONfsnb625HVN2RhViXphZ5ZFfE/V
         bAaOu9VX7VGYCaiQ62vFYSfQowQQ624Gi2y+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F2pFMV2RQXtj7Yzz6U7H9/qhPmhQ/n2kJAXbFxzQZss=;
        b=F8eXJU/lIjuIchtWo3Za2gPnuY5J3lF+cDUj4Zl3PMOJlKllWY64j3Ma0jDWajZX0M
         iY0MdBXiUln/rzPyOgfePCMqU8JuZgCD7x011YdblzbbP9A1weqSEBL/ESBdJjpUaiaT
         usjo0gn58kOfjVAOKVtIQUb55Aio3AAJMGwp9FE6qBItN6iLMqKWlVSsna9M62lPW2rv
         F965JDWG+szWoOKu3LiP2m8l3WygzTSbKtMuz4UumDbfnOzy7SixqTPLkZ6UuF0bxagS
         824LnVFmcPalEbJoPI5KkytfkD6Q6XcyTxjH8X9t35uHBZl6I4bcc1Ecor8k3rx/2+f1
         W5yw==
X-Gm-Message-State: AOAM5308LKkLwYHmTCvmSnL5T9fiAxxid0BZNdftNPZg9vTRDW+uBUo3
        0+oPbfZnjRx+VBTm35Yw5cioZ1eZLBDBZg==
X-Google-Smtp-Source: ABdhPJxmLGJB13KbRWxQXh4EA1+j7Lmd2IzQw30EdJ7cLWtkw0WefZsCB/lSsEp/1EtQcTzHCr2yQw==
X-Received: by 2002:adf:fd4b:: with SMTP id h11mr16740246wrs.209.1590925181131;
        Sun, 31 May 2020 04:39:41 -0700 (PDT)
Received: from noodle ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id v19sm6021972wml.26.2020.05.31.04.39.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2020 04:39:40 -0700 (PDT)
Date:   Sun, 31 May 2020 14:39:33 +0300
From:   Boris Sukholitko <boris.sukholitko@broadcom.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, keescook@chromium.org,
        yzaikin@google.com
Subject: Re: [PATCH] __register_sysctl_table: do not drop subdir
Message-ID: <20200531113933.GA22327@noodle>
References: <20200527104848.GA7914@nixbox>
 <20200527125805.GI11244@42.do-not-panic.com>
 <20200528080812.GA21974@noodle>
 <874ks02m25.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874ks02m25.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 09:04:02AM -0500, Eric W. Biederman wrote:

[snip incorrect root cause analysis]

> 
> But the insertion of children in insert_header also increases the count
> so it does not look like that should be true.
> 

Yes, I have missed the insert_header nreg increment, thus making my root
cause analysis incorrect.

IMHO, the bug does exist in the latest kernel. Could you please see:

[PATCH] get_subdir: do not drop new subdir if returning it

I've just sent to the fsdevel mailing list. In it I've added invariant:

WARN_ON(dir->header.nreg < 2);

at the end of __register_sysctl_table which the latest kernel fails to
obey.

The fix seems to belong to get_subdir function, therefore I've broke the
thread and sent a new patch.

Thanks,
Boris.
