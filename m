Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1E81BAAEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 19:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgD0RQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 13:16:02 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:39247
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726177AbgD0RQB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1588007760; bh=DbsQgiQ7jFkqiGUOueNLUsQEY4h8CqVP+e1O0N4SXO8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=d3HTlCL/kRxILbQ0xopaP54B3mA+pVbcioUIWEFQUGBq//PXt6iFkr3vCeQIyNZJrban/Yv26a0oePYHZ3bZN2g66uxJ0gzS5sOl4tMtcW6aUpXD/whkWkdAtneaIXIKxwSNSRqai91T3U3/CwsOLHVlYx8B25lL1V1IzD7Q2TCKTiSHEiFT58BLTTHkAZiftjU+86gMMeCxIsH+yQAlz+yemGDOmHQaVznw3jg6479c1NE39Nduo44rz0GYIbiAW2xTSo862/87ExOippgBSeB8WOdtYC3WePiNu3EI9l2HHx5sJEIbhqQWXofjWD2LngiFEMeC2SAAMd4ALn0WBw==
X-YMail-OSG: QlXZjUcVM1mxlifsA2eR1Cshu2wWRzKsrEI4MVRowC_y5Q9McFsrKpp8njpWhe8
 6CsMkfvhFGc2.wGjkTInHr4m6Kl86bber66byEgwvlsGLU5uGBZ1ygweDZvzuAQi9LkGqeQIiKZn
 bj5CfaoQO07FEJirlyq9kYe7MwtppKTlBFK7xsBMtHSV7yoCvPm.U9Xv5p1w.1f9yDbFS0VmCidS
 0VN9QbPKqBaumj._VBglsOTzlTVn9015PxzI7FRbhA9Wa1_hbGncU7NE1vHozHEgqpPBWrKmO1D6
 ZW7aGnd8kK2mnGUa2kBpWpMRLDKkFtHsEaaVFQDA6eHNKIDHEj3u3rpSZR5dH8Sj372W74WAe_Ir
 zM3cp336htmRIjJ6WvkLzFbjK8AKcXEbbqAY2fJN0yAqYfeuopVjpXGeT9xRnUm4c2xf6T4JKTkO
 aHKx22M6aExPT2t3YU7xKCT9sE5vZoPaiokLeN.zt9KweU3pwQBQJGt8_VjhWMnLR3W62l.m.pi6
 l7xoQDAu0dm9g822RrM9yiaj3IJuRkE6YgMzXmhmrHeOzY43DNmN2ouNywpJvfEy2FbwPUUrhF3R
 gIfvonGvFroA_9J0p_BbwSEZtCo47bbyx9IrpDC3gmI5fFJZa42nNZOcdHvN61Ymun9swNAZHSDm
 jK987PwuFsSNWRUpwlFBMajEtfRNqpCkDswIqYhgBVI_EUIFlPz9C1DFork4_X3Al0SoY6sbLVq0
 BoPvhKHen41b4tiEgaY4TEk0W3Aa2xF_xqUYdD6CalpspWIt1g5wKzlTtCFJLtwNqRJoDZh_Na68
 4wmmboMVoFi1u03ugCogqd0Lx9MXam7HLkBkq9VbKolUZ_dnhdydBaEGgOEQqFevzDI6cYj5MqY3
 26N_upFxq5coJVbmsVd59fg79KMfCy8pQSnK6oV4eLba03cCvte4xnn4ehaU6I57sQjLHogsAp4f
 BFhIr6UmH6j_y5PFBFMSPaqH6VBt4VXT0Gfq4aoP3n1gmh22Uj2lPmI2Ge8AZ7ly.IZ_AWrUt2Tp
 hJnxW56ZA4UT09t_9w04KPXkmzS7sf8nOHoLZQGUQccLMZk.PdefimxE5Keeqf7KZ05gu5dKOKk_
 rYDvaLfLOIlWEfbC1oDQinu27TP9QOEE9OuElNz2qDIs8tsdM5uho.DMHyeY7n3yCozFm8vFQ8YW
 QNetMLpdhKAPh2eO6wfEJyvZIKP0k90nMqFe.M5mADp6tVYbyhm7A_IuXvGxDA9rqxPG6.l1tqDv
 yhctlPKbI8SiMEPBstKxHYMuC8QawTiCnxPiIaC9y4u4fLL23GqrzoTL0S0JqukDnFirOogMxFxZ
 N1j_iu8TS9HXVR92I8sjvBUaUotENCdXaHRFREMS1HxTDCGrGNMK3nFdzK.oCXHQNajM3hAFzNdP
 trK1ojFZN096UrdIlb00CQGXyN.3LjEyFezKz8likmRKV
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 27 Apr 2020 17:16:00 +0000
Received: by smtp406.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5c417b4721e3b6d7d6ee1e185595c6b4;
          Mon, 27 Apr 2020 17:15:58 +0000 (UTC)
Subject: Re: [PATCH v5 0/3] SELinux support for anonymous inodes and UFFD
To:     James Morris <jmorris@namei.org>,
        Daniel Colascione <dancol@google.com>
Cc:     Tim Murray <timmurray@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Lokesh Gidra <lokeshgidra@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200326200634.222009-1-dancol@google.com>
 <20200401213903.182112-1-dancol@google.com>
 <CAKOZueuu=bGt4O0xjiV=9_PC_8Ey8pa3NjtJ7+O-nHCcYbLnEg@mail.gmail.com>
 <alpine.LRH.2.21.2004230253530.12318@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <02468636-c981-2502-d4f4-58afbf8506b1@schaufler-ca.com>
Date:   Mon, 27 Apr 2020 10:15:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2004230253530.12318@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.15756 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/22/2020 9:55 AM, James Morris wrote:
> On Mon, 13 Apr 2020, Daniel Colascione wrote:
>
>> On Wed, Apr 1, 2020 at 2:39 PM Daniel Colascione <dancol@google.com> wrote:
>>> Changes from the fourth version of the patch:
>>
>> Is there anything else that needs to be done before merging this patch series?
> The vfs changes need review and signoff from the vfs folk, the SELinux 
> changes by either Paul or Stephen, and we also need signoff on the LSM 
> hooks from other major LSM authors (Casey and John, at a minimum).

You can add my

	Acked-by: Casey Schaufler <casey@schaufler-ca.com>

for this patchset.

