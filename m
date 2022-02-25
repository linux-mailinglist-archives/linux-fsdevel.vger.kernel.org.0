Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940024C4F52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 21:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbiBYUL0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 15:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiBYULZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:11:25 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D545F1F6BDD
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Feb 2022 12:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645819852; bh=VIMmQ6tBpfxtmjNLfB/k1a6q+FlhwJdkIqKV0mLyzwQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=iFAIDNTmCTfscIXyQBAO+aKL1i2OcQPuEXDrBgTV3ZTHzGTBlYd7C8ApC+0ZIgHKKFG4UR3zRhBWX6FZ31/YK9So7tIwPRLWDqXCMniAt9f3Ez3sz4zQEiyQqo/ldX1lMMsCARfvcQAFilBq+37dvEclblNgzaq23sgKqNeboH2WCR56TD+xa/57Pv3KbjMZCQlA6xsHNNmDx9ZEo/OZiHA3DvbIbO3gHSFxl6BQwUkbWsCCNm4owpP2v7HL2bgMQgoIfzqKFRSwMaufhrXglU0bxr2wkCF3yRWPdWMMjoTVSrmn7DuJHghfDXW/DSBkDMXRsHPBJvoPju1AyrxgjQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645819852; bh=diQgyBR/CYKA+Ksh2/YVW5B2g0dAQJwI+qcY3IQuPob=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Ox9+rDq1pxImRbraV8q2sUa8Vmlq/x9XXjYFfJw1lEsI6B78NdRfU5hgU5xGcn3RmtIKXzvLxCe96JTKNNZDbWP/qgotzcRBl8FtIIrMhbf6poX7tCzHrGdL850SGQOZ0BzK5OtIwTBDKvEJDHUKT8y78T7J8oCMPmBwlndM85g0A3IAFNLVbQU1cKBDMB0CqMDn023OenPQL/NMVPWkDyL6dAKT+sBVfZFaG/H0b2ZURAKfoVdD1H3JS8wz+a575n/GsP/O5rjbHfYoZ8pOC36uvej147KjUgVoISt7sWSCprJVDVtClIbtcW/i6eVBwsh4+wKhNMVOyx6Nt3xLdA==
X-YMail-OSG: euJU0F0VM1mz1DsfXdaPFvqbywOX.luUM86NE_CSmXkFbbzqz6hgGPrYquSLfIb
 B76mmdA_aK65KCx1nLHQ.N4NZlo0bzjfrDur8.CFlaVH.W3Z1Jp1Izh.uyGHBZGE1QHX5JPhJWTG
 btzhU38nu0gUDh3RUbcLybI5idjbKn0iO3tb.6PX5WLovFcNGZKTpixAlC4b7ufT8cZxHUvZw2Y0
 l7wOG60a3uBow1MVv7GI20WOn2OYwQOSbGxjuhwd1Rv5wzXUcZIuSHhadVj23ayuSdHhqFMGFm4n
 kvKcz0gxJ2kiLsjfCmRUMaUU3RlNu8VDUgk6kvb.JSxaaEFyvKfGZ9BpwiTg2COslOlL4EvhlRsV
 kNMc86NAFhmy5Fd7IbMqo7uTldol3R.HP1dH3LxRFZs2LCPwmjJNkFKcQr23AgICBK_GolZyImoB
 RMckctXd9uN0kNA1U8d4FGP4zJS_KYh_4GnkTYf4LJ1GUVkbV7FCblfaSqfvtqpOQo.SZ7KqPYDx
 60xn2GUQ9KCexlR.CYjZexxQQAlHZIfUBPVbVgj04zL7p3wxbV1Jkl2ZRhJoo6l7o2apR4G4rHzF
 uCAYDE.JnOcqZn.mDsddOb8uiMDgsLsFdi7qTX6W.UABUXgDYhrG9SOuYPaWH3p.8NhgGB1wwsro
 Dk6obZ8G6YwV_tCZSAevNo4yR67YFC4KOGigC_Cm_lPT_xClmnMcIiPlML4AC1NDfEPMW5N9lt4X
 g7cTNNZcOA43TQG6s17XA1lwfOeVA7XyRvFo_hcSt6XSFVSrBwf6SppuYGf9axvOJiniDw6zSPbq
 2XgKX6_XwOuMuVONLhf7opDgCQ_icpGs.Q1lrFzG0LICZesbEMoHa4LbWV.Z2lhgIXhB9nLyBrp5
 tOMAg_jZvZorFRe4_W5HGcDHIX0orIMoWBo6v1QkUbS2Jb3nV4yA8RGoGL1MfjgkwqRnXB0PhdD.
 8cP59BsN8PfJnIMjQrGokXdHV9LA5JIPBAXPnYVOEyQzncgFqMEp.t.zEqotxqm5nwMrFIh2X9ID
 GLs9j7Dk3hGz8e.r6O8hPq5iNkQFt00zLLbzWpNV7RLVXeC0uqyNWgECl0Co45OLbOh2h54Nqeay
 6O63AqQO4lIbcWM17BZBNnR3VcgF1plFJH8RRC3qlt1.ODqFlM.XPNKZABuZqZuadsXEKe2d1iqH
 gveNp3JsigwwuNvCh_1r4RHMI8ZEV6eifdc1V0iI28o4tJIgg5oq.rqppwuc3.uZnmg5g4qfne.S
 FvLmabF7SYzvhVvNUYG1GGbC4TuQo9YxYPYpkddF.e6Qejr4zIs0qt8XQP2_5u729y42pLbY6xRE
 t6HtvUnYoq_izTRwz5XbroHdim0Qeiz0CWwHA8ZpVrJPR2hvagHEv5KnACEu2MI06jSM7uikvHND
 WF.e9GgzcN2h7X3Imv3qCzyFY7GC3jXCC5RNto9uSby6bjyIOwl9t2399UtuVb1XZxut3yhO9kQE
 j67SE8ljTiczZtAdqEfU66o6AiLuuTO9UBGgiLVAr3RhNqltkURfUioAXQ8I2_FyUbR7Vb7KJGYR
 I2QrER9kWlMfWyHbBcuU3jKBoQKczA2DlPn3gjaOPhvx4kHNORNViXi4bX9LYwGioVxduY1f3xrm
 z1AxPDRCxDTa27FVVPYkjPrRX9gkz4wO0l5SIsqZ_WJGLw0nt4Yt23ooPwBmbjJ3icrcENRbY1rU
 EQ2.9_PWza780UURQpAtrI8YAIUi61GF_z9C5Kk7VLeQy4Qtq499cxeFpNbQUVJvJOXFyOZy7Pbw
 8cbrHC4hKu0LPgb5P10_gixcTq1WV7_nRHavrsTBzLlLwgmdfHkownTfXpXk94fUmGagM7JhhQxN
 XRBRXqbKF56Srug9e7zdyYkzuhQY2Mk6.iJa0YTARd9SgOAcsRtaQdWVeT_vjx_D4B1_niPjQFwK
 TD9Za2Gd.eMKAAoja6fp4LdCPuxgTTl6bWaPxFW_L0lNkMGPPlZZlqwL4DkqlrVzrbtvz24iqfdN
 dqsOAjoE7aHvODif54RqUHX0O2b11qE5jKmqp.l0a40tlWjZStNUVLPrxp4eDCquZleNrzi9dScJ
 3vVN0Yword6f2B2g_YO0qct5IQem63.4eZLg7bbU1XQ2VRtFCb.D9QNXGvO3qqEskloPIv7MSlct
 OL3.__wQ3utUndBgh054.VviIDhi.N.UZ_szdW4ZilJnqjmgu4U1kGwAIsAc1I8EFGrqINKdoTba
 6V8Vl2maqJbSUzhCMTAk4cyg-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Fri, 25 Feb 2022 20:10:52 +0000
Received: by kubenode514.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 9e2dac2759d13d17e1e1ac39d4c0a7a5;
          Fri, 25 Feb 2022 20:10:50 +0000 (UTC)
Message-ID: <686276b9-4530-2045-6bd8-170e5943abe4@schaufler-ca.com>
Date:   Fri, 25 Feb 2022 12:10:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] userfaultfd, capability: introduce CAP_USERFAULTFD
Content-Language: en-US
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220224181953.1030665-1-axelrasmussen@google.com>
 <fd265bb6-d9be-c8a3-50a9-4e3bf048c0ef@schaufler-ca.com>
 <CAJHvVcgbCL7+4bBZ_5biLKfjmz_DKNBV8H6NxcLcFrw9Fbu7mw@mail.gmail.com>
 <0f74f1e4-6374-0e00-c5cb-04eba37e4ee3@schaufler-ca.com>
 <YhhF0jEeytTO32yt@xz-m1.local>
 <CAJHvVciO1GUbmL+Rxi-psGT8V=LyTfGT-Hyigtaebx1Xf+z6fw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAJHvVciO1GUbmL+Rxi-psGT8V=LyTfGT-Hyigtaebx1Xf+z6fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/25/2022 10:17 AM, Axel Rasmussen wrote:
> Thanks for the detailed explanation Casey!
>
> On Thu, Feb 24, 2022 at 6:58 PM Peter Xu <peterx@redhat.com> wrote:
>> On Thu, Feb 24, 2022 at 04:39:44PM -0800, Casey Schaufler wrote:
>>> What I'd want to see is multiple users where the use of CAP_USERFAULTD
>>> is independent of the use of CAP_SYS_PTRACE. That is, the programs would
>>> never require CAP_SYS_PTRACE. There should be demonstrated real value.
>>> Not just that a compromised program with CAP_SYS_PTRACE can do bad things,
>>> but that the programs with CAP_USERFAULTDD are somehow susceptible to
>>> being exploited to doing those bad things. Hypothetical users are just
>>> that, and often don't materialize.
>> I kind of have the same question indeed..
>>
>> The use case we're talking about is VM migration, and the in-question
>> subject is literally the migration process or thread.  Isn't that a trusted
>> piece of software already?
>>
>> Then the question is why the extra capability (in CAP_PTRACE but not in
>> CAP_UFFD) could bring much risk to the system.  Axel, did I miss something
>> important?
> For me it's just a matter of giving the live migration process as
> little power as I can while still letting it do its job.

That's understood. But live migration is a bit of a special case,
and as mentioned above, is trusted to do an oodle of important stuff
correctly.

> Live migration is somewhat trusted, and certainly if it can mess with
> the memory contents of its own VM, that's no concern. But there are
> other processes or threads running alongside it to manage other parts
> of the VM, like attached virtual disks. Also it's probably running on
> a server which also hosts other VMs, and I think it's a common design
> to have them all run as the same user (although, they may be running
> in other containers).

That seems unwise. I am often surprised how we're eager to add
new security features to make up for the unwillingness of people
to use the existing ones.

> So, it seems unfortunate to me that the live migration process can
> just ptrace() any of these other things running alongside it.

I get that. On the other hand, most of the systems you'll run
live migration on are going to have full-up root processes,
possibly even userfaultd (in spite of instructions not to do so).

> Casey is right that we can restrict what it can do with e.g. SELinux
> or seccomp-ebpf or whatever else. But it seems to me a more fragile
> design to give the permissions and then restrict them, vs. just never
> giving those permissions in the first place.

If we lived in a universe with a root-less reality I'd agree.

> In any case though, it sounds like folks are more amenable to the
> device node approach. Honestly, I got that impression from Andrea as
> well when we first talked about this some months ago. So, I can pursue
> that approach instead.

I think that's more realistic.

>
>> Thanks,
>> --
>> Peter Xu
>>
