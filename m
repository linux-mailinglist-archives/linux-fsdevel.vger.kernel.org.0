Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1703F2EC906
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 04:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbhAGDQp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 22:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbhAGDQp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:16:45 -0500
X-Greylist: delayed 1972 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Jan 2021 19:16:05 PST
Received: from dancol.org (dancol.org [IPv6:2600:3c01::f03c:91ff:fedf:adf3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD90C0612F0;
        Wed,  6 Jan 2021 19:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dancol.org;
         s=x; h=Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JnlQnHhx2b5xdhpAiAME0OFrhEsB0VJN8KeeeZquzsQ=; b=F1JnKxldsbMpLgyuQhr06+ON8y
        hfuDQ7Qg1WSpHoE8BZjsBZugCrN3usRSfaQ2FPlak31Iesh1rYN6U1RlsboEKl3A2lK9PqCvfh1PR
        mLjOK7gcvd75e6UDOJrpf2HgaseIhPxNMEmmgG79gzwRql+5V6d0LLUpdUhN4fMIgwU8GVqWyXVie
        ekOA3zikq8x0O2FTKKJboEX0Kx0vaXh8sgDTgVhV3e24a/87KMPNGDav6SQYxVCj0OvOnGpo4MEtP
        trF3AOJVmSU47zzhuABT9Df6aq38An4qH80V+/i9NhMzVYJad0JRzIu0B6EbAwl8kod4cEB4In+xb
        96df383w==;
Received: from dancol.org ([2600:3c01::f03c:91ff:fedf:adf3]:53614)
        by dancol.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <dancol@dancol.org>)
        id 1kxLFl-0003na-DZ; Wed, 06 Jan 2021 18:42:21 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 06 Jan 2021 21:42:20 -0500
From:   dancol <dancol@dancol.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        jeffv@google.com, kernel-team@android.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org,
        Daniel Colascione <dancol@google.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v13 2/4] fs: add LSM-supporting anon-inode interface
In-Reply-To: <CAHC9VhScpFVtxzU_nUDUc4zGT7+EZKFRpYAm+Ps5vd2AjKkaMQ@mail.gmail.com>
References: <20201112015359.1103333-1-lokeshgidra@google.com>
 <20201112015359.1103333-3-lokeshgidra@google.com>
 <CAHC9VhScpFVtxzU_nUDUc4zGT7+EZKFRpYAm+Ps5vd2AjKkaMQ@mail.gmail.com>
Message-ID: <f7dfe33a4d0f9c27f3e25f72a988201a@dancol.org>
X-Sender: dancol@dancol.org
User-Agent: Roundcube Webmail/1.2.3
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-01-06 21:09, Paul Moore wrote:
> Is it necessary to pass both the context_inode pointer and the secure
> boolean?  It seems like if context_inode is non-NULL then one could
> assume that a secure anonymous inode was requested; is there ever
> going to be a case where this is not true?

The converse isn't true though: it makes sense to ask for a secure inode 
with a NULL context inode.

