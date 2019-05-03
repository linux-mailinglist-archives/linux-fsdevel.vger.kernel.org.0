Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 729AA128AE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 09:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfECHXp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 3 May 2019 03:23:45 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:44038 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfECHXp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 03:23:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 52FAB6083136;
        Fri,  3 May 2019 09:23:43 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BzZ_z2f9KMyc; Fri,  3 May 2019 09:23:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 083356083139;
        Fri,  3 May 2019 09:23:43 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id il7MALYYXiat; Fri,  3 May 2019 09:23:42 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id CEACA6083136;
        Fri,  3 May 2019 09:23:42 +0200 (CEST)
Date:   Fri, 3 May 2019 09:23:42 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Eugene Zemtsov <ezemtsov@google.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, tytso@mit.edu,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Richard Weinberger <richard.weinberger@gmail.com>
Message-ID: <893598216.43321.1556868222776.JavaMail.zimbra@nod.at>
In-Reply-To: <CAK8JDrFZW1jwOmhq+YVDPJi9jWWrCRkwpqQ085EouVSyzw-1cg@mail.gmail.com>
References: <20190502040331.81196-1-ezemtsov@google.com> <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com> <20190502131034.GA25007@mit.edu> <20190502132623.GU23075@ZenIV.linux.org.uk> <CAK8JDrFZW1jwOmhq+YVDPJi9jWWrCRkwpqQ085EouVSyzw-1cg@mail.gmail.com>
Subject: Re: Initial patches for Incremental FS
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.8_GA_3025 (ZimbraWebClient - FF60 (Linux)/8.8.8_GA_1703)
Thread-Topic: Initial patches for Incremental FS
Thread-Index: pKGNKPQ4PIl5hVZFuWPWS0wPcPovwg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eugene,

----- Ursprüngliche Mail -----
> userfaultfd
> As far as I can see this would only work for mmap-ed files.
> All read() and readdir() calls would never return right results.

Yep. For lazy loading a program that should be okay.
But now with more details on your use-case I agree with Amir,
a cached network filesystem makes more sense.

Thanks,
//richard
