Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6904B664F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 05:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbfGLD3t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 23:29:49 -0400
Received: from namei.org ([65.99.196.166]:34804 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728955AbfGLD3t (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 23:29:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x6C3TXIY022499;
        Fri, 12 Jul 2019 03:29:33 GMT
Date:   Fri, 12 Jul 2019 13:29:32 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     Aaron Goidel <acgoide@tycho.nsa.gov>, paul@paul-moore.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        amir73il@gmail.com, sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fanotify, inotify, dnotify, security: add security
 hook for fs notifications
In-Reply-To: <4fd98c88-61a6-a155-5028-db22a778d3c1@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1907121327150.22212@namei.org>
References: <20190710133403.855-1-acgoide@tycho.nsa.gov> <4fd98c88-61a6-a155-5028-db22a778d3c1@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 10 Jul 2019, Casey Schaufler wrote:

> On 7/10/2019 6:34 AM, Aaron Goidel wrote:
> 
> > Furthermore, fanotify watches grant more power to
> > an application in the form of permission events. While notification events
> > are solely, unidirectional (i.e. they only pass information to the
> > receiving application), permission events are blocking. Permission events
> > make a request to the receiving application which will then reply with a
> > decision as to whether or not that action may be completed.
> 
> You're not saying why this is an issue.

Also in the description, please explain the issues with read and write 
notifications and why a simple 'read' permission is not adequate.


-- 
James Morris
<jmorris@namei.org>

