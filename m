Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EDC1AB79A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 08:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407261AbgDPGAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 02:00:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33195 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407207AbgDPGAP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:00:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id c138so1203914pfc.0;
        Wed, 15 Apr 2020 23:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FAXeeAl+06npcabuQvuYuTP3jQapHCqy0Znm1m8x2B8=;
        b=iP6f3iMHUfMmkbuyoThhrT00qQSQkzJMJmkB8O0Y6zk/6F7bDP1uwppX7Ax1n4pc0m
         ij1axBsmWvIKBXyZVsPULpNtPE97C1YVNJHXsgMVYkUx/qnO7/xhZJoiIRtRoZsVZ0lV
         XfcrzdjOqL4ifTecs2St0d40XmxWfmXAg2rHaGFqgMmgSvpzCbwcc+wiEACnfpEgMFZC
         YfVCzOC1WsULzNqy77dVUy8pnfDfqFx8q1Ng3CO4DBWR6qnuMeGHZbNniN0nCaSjQYKp
         vks11fANGSBanXTx6szcEvbfU4jKldxecEvXYW0Z/9k+kAbqd/DP/nzg+MiU5NihyX2b
         jg/w==
X-Gm-Message-State: AGi0PuaWQf+05rcZJG6RiUM1IEFoxQO/TwtlbKGANikoY+BS79aPoIsh
        YSL/DhntgM98mh3ZUWHe2uM=
X-Google-Smtp-Source: APiQypICnolUc2W/UZn/odHanFGW9jsn8iT5iFZCqWPgDqKQJOk8NCqaY2uIAeFAHoAedVh6nx2WBg==
X-Received: by 2002:a63:a07:: with SMTP id 7mr29039722pgk.261.1587016814132;
        Wed, 15 Apr 2020 23:00:14 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id z7sm6449944pff.47.2020.04.15.23.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 23:00:12 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E2FE740277; Thu, 16 Apr 2020 06:00:11 +0000 (UTC)
Date:   Thu, 16 Apr 2020 06:00:11 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] test_firmware: remove unnecessary test_fw_mutex in
 test_dev_config_show_xxx
Message-ID: <20200416060011.GK11244@42.do-not-panic.com>
References: <20200415002517.4328-1-scott.branden@broadcom.com>
 <202004142010.C0847F5@keescook>
 <e2b95fde-0ab7-c0d1-2c64-cceffc458673@broadcom.com>
 <202004150943.01DF9E85@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202004150943.01DF9E85@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 09:44:31AM -0700, Kees Cook wrote:
> On Wed, Apr 15, 2020 at 09:28:18AM -0700, Scott Branden wrote:
> > Hi Kees,
> > 
> > On 2020-04-14 8:10 p.m., Kees Cook wrote:
> > > On Tue, Apr 14, 2020 at 05:25:17PM -0700, Scott Branden wrote:
> > > > Remove unnecessary use of test_fw_mutex in test_dev_config_show_xxx
> > > > functions that show simple bool, int, and u8.
> > > I would expect at least a READ_ONCE(), yes?
> > I don't understand why you need a READ_ONCE when removing a mutex around an
> > assignment
> > of a parameter passed into a function being assigned to a local variable.
> > 
> > Could you please explain your expectations.
> 
> Oops, yes, you're right. I misread and was thinking this was reading
> from a global. This looks fine.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
