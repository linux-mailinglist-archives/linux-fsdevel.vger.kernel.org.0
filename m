Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA01D3E045A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 17:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239159AbhHDPiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 11:38:00 -0400
Received: from sonic307-55.consmr.mail.gq1.yahoo.com ([98.137.64.31]:36940
        "EHLO sonic307-55.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239112AbhHDPh7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1628091466; bh=6jSfR4RkPcnSRnMkpVQncMs3ryHAVdU+cmeHQ0BbqHc=; h=Date:From:Subject:To:Cc:References:From:Subject:Reply-To; b=KnxNe5eoehOGpszLZhqboPutVoPS60AFmgMfK5ngrQtiVLG2KKxp0V9Yjozh9QBGV4GzB+OmwL+4U+Yp8mPiPjPAnYuqR1P3ijuOZqkpNK7fUJiHuCooLJbhTg4hm7mCF0SIn1DeSiXtPqZzconV1PInmBPcVI80qgxB4N3jvPqf4+NW78A+uFmoOykzWAJetlpAhJOQo/DMSiBQ+wNLj4JInTxZT7BZyelFUAOcN6jTdlA+o00pGsi4JWnNwOOBJ4MC5PMZJKrnNrtw7Uij6tg8n3lsSBOZR2fRT4ivjN87zrlyFEQ3rfXD0DWSYH7V32XgVGKTLO10kiXOiX/q7Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1628091466; bh=gBsZXjYB/j0l5ThUSFF53727IB5bb4xnZY4LYt5VYEn=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=dzTLa7V0gNyLAllxYbWWNtp79lBj0UvNR9Gh4Gz/Pm6k96/4NobjblkWJN9ifZH3et92qWcJMZXddNFmF2nlv+DdBULRg6HAtHUwfL6cRn1xW5oO5lk09B21Sb4e5i24Z/sUQ5qa+qT0hMmOy8IVQZM6pFv9Bm7Ssf8IxeR+9/+3f4zHD71tIXUcEHAjlKhnGJFgt9rYec6+7DDasEbdLwZsyj7rI9ogd68T/p9LGNRPMitlGl28HXrRWUZ7A800Y38RPG0Pmn8kJ6c52fcs8Pt5Y7+jTJdwjQV3kqoBixrPS2us4Fi/WUFjZ4pCcUlrpPdiXnV1JfBLLzfWkvGXHw==
X-YMail-OSG: jiDCXG8VM1k6Wo07ynRe4MVO6PawH9BoiGoh.TZKrORt2m9ZNNtDOfFb8OqsAew
 hHxH_OG4n2vIh.FlgK44sOnN7j5NX8iRJ1Rs588vVg0E3WTSqCq55vom9xccqeCcHLp_2pcXTefJ
 8asyRQAPfeIK3ZVWoRtxPiMlptKPZCCnxSh0Y3hyDMmRJinYYBdk6iVayKDoKmJM1zr0WYL0Cn2m
 10HuYh_Ce2pXDtXVKbF9rMC29RYG9fu7zyVeDN9RP0J5QE4Fjko2JJcTheTf_6BMVMIWXo6DK2Mn
 nQb_YWAyLGE.09AEtHIWFH6hUqWOLPUxonYgybwhfgQkFIDsXCsnIGZ3acTCCVPUbHlAOSYXuve0
 PTqhCiUB6hSYvo._YsTXUOooIJZ3ZT9IXnu28TwAb53doETvAEWEWJaFoUPBvLHHjzYgtmk8j9QZ
 NUbZPOw0uG.Q4McDmNjuSvjzfvpKDr2wuy_VBYhsWnW8VUOQ5a2Pm_Tu1fl6tLvofLi4j6e6u14p
 UUXfIQ5REWSRju2rF3UvmHRmBaipMBZetu1PaeNUXaI0d8JmWMUtsedbGjvwg6ZzlB9CT9NqUz5q
 ZvG93ZL6g5rFAdbqc8U74EWziq_ySXi2SmHY4ztHlQi6Fzb400IH6BLPijFu8jtghMRq8GLPJ8eb
 nPYlAkXnLc07DWwFUqdyno6sZI8MVTv40MxWixno.VABbGG7LErHQGI518DJ6WONXIxNdJbJYccm
 SVod4Zg40pxtBd2YRcpG9CnJ_7zf9A.M1qpM8yhAapNx5imRtLyAPLgaHIzSbo38aOJ_l26xIsQg
 WiIUi_a8a.xL8HuJ6ycRIMG.xOBptzYYq4bU9UL5hUYQy96Ho7rvBA1FOg.Z_SiOJ94eJ_0nXMVW
 Mes.3LOxYbuRinh5P3mXMA_.wY_NsAZKbnzNCOGIVFvRHFc59j6okC0j7JbCAvstT1UivxEdg1YR
 4b0jJBi1Fo5yhIv210RTDDEfoY7iUDVVZcm1h1jaOsxOetMTZl9T8JPh.Oko9tkVApz0e6JDp80D
 VgvDSZqQHM3r4WWgA.az.WW_xmjsys6iwjH31G89vhQ8AvvwDHZccj1dcfFxKZAFXiRkTEYPbLd4
 4zk.I8K9WlR.PHmfcMAVlKznkUQCVc.ZTsrSN.4.pRui3maupoeAAdT.Mu5GP5Y.az1iHNGlTQrO
 JFeK78DYXGk.mvcu8XZqECfIenrejTw4O0JSlGbAzy9IvRJzFHnJ6Y8uUj9xAbXKe2xY8haHSgzE
 GWqlqFTWaVt7wdmNOOKzopAmrvZZF1HkK6k7gEqEl4X_lnZf8VyyGGXK24tZD2_cCi5TMueTBTFG
 dGWIQAItZznOrbXlGZJXBAA5dhVmKkYGVYgx3K7UwalN3gEtNaBOnQhB17.upjucP5riuMCjsAOL
 6LHBAbFEgV.Lrnd2nPu1IrHJpjP9MdDj0CmU35uPuASb1iTEst5eAHzAp.wLmpKgRKYWqId4AWIF
 _vPSVzr1lgFrAOG1G_WsB_Vr7kvoV63VAlkIP5WRnNzxb2TtMibXRT3MUtOemXE1tee9JdhahT9p
 JZq2DFQ0rKWqGXgI8lZz3abZgShjLYc_iKRtnWpthx_dxd7BvCxmU6ImQOOwYoJtfCFsAgUxngM_
 fDoc20Y1ttKvssZ_VcwYNv4HkXl9OZRqacMhuAz8ua74_kOrCfitrjWdURFztE6J1N.X316jFSLW
 UDNCSFIAd5rIn2t1qWQseOQFPQUHZ4mOzvjLiskASAgqDX7d5ZoZVMPXDffAwQHCYxU6h2FQKKOq
 cWdTEE97I.RDdIdBocbIVetqiVShdSkFw9GmdsIfrkMtmpkqlK_zrwvE9rVLn7j711TTLf0xCKBz
 0w8Yb.bd4E0yZvrfd3vz_IRcYNUMmbnDNyXi.pH8fI0fIGvlMeUIzNF7azmAO0X_4i1yZ5uFR98g
 satm4TWjzd3FpRZelBRq1aKVzG.V4s3pb6jpUVvkh762_5e1m_.i4IDAv6d1ObnJhB80XBQefsx3
 DKlc2k5iZbg3nW_uv3kAGMdd0rSpG7q9K5BRrBgFET.09NZEeI_eVJST03XJKCARwHoFcD_qQMU8
 tSbinOTmCxpuS6uZcNYdj.bNewoKx1sgwq9eJVsq2zxjibGk9mMOuVfPuEyRBCYRf2dPp5sIS.m_
 H1zNYp86E.Hn7yEXjMUjhsvsCPHULepKuT8Jh_ajPU6mUXIDIRcUQe4jLNt2Myl3aCAOKoWEYwB1
 .1W9sG2Y7eJ.p5lwaspch0hkAdEI2vXkeI19G5DVxY5LOMjIPq.E_jW6kkaCGNTRnY6d08yG2HvA
 ImzlcTO1_xfSa4uGjRaeDzDnOnFnFxJeC2PVWN0d.3BnnscJ.za0I_6u2dQlT.i.2zCSETb_nzbC
 CZrk1OPaDy3mq9CCDARFwz7pppA20jQHP3zi_l7Xz6gtvFIn6IamSrUxuDxeZpci4zPZZaQs0Hh8
 wb2QvQGndO83th8Rr.hvbwsLK5b2x8krXfXjAKsQT.89l_OUmCgrH1mgVb2PaatrRjCpQCob9DA0
 hCg11MHKdNjTSDy285xdkSruSlygooc7V6fgW4BHP5miTrbwMqYS4wQxZhjkGlh_iYxftSYNdLN1
 G8d8VUaXVn8hW8YEvgBFISUP0Zz2AKjlA1plI7km.JkkrourtmzmJGghzvw07AHSkiukNMmXPJ2t
 kfR4KHyto68km4e9Mf4MpNckLeVvdxdNsPvjta2x1X6Ec02ptDbbWn6szW3HAkDay8atcdZecTvR
 VTU0UvdryaZOSpNNHiv_RR8F1O7BD6tabpOS.WEG51c35hJhtTKuQeT1eVBAjuSZPxM.CskAoo8P
 UqV4TizZuFjqfTp2b_JJxSK11MRN.XNz3op7KvYgJOxkwZoCZcCQZDjZvc9.60wrzUPvqlXeozgz
 eKU3FNok8Oi4anw.YnIXe3dXuTjlhwuRJHSagpfX5uyRciGPopPoGpuPznC9_RFCJrfEkYLpUW8D
 sZJnBYtlSZaef6sSQmBk3QlfbmTwbVDRvAaL5ZrB9fd4tV0NJgrl_.LPnAN5NLf2gJLPfMgJC.ea
 oR2Avty0ZQmbmed3h7tA18lN42.z_FBTlVB72YtMi4QT0yEELvPS2rG6J2SXMaLdtPvO_JIq0_XV
 UJqES_bBAo8Vym8jRde0oOmhyoXsi9PrJJ50N_MvNgQnBUTt5uU92Y7WuJ8evJVX6YcuA0yvl_sG
 lKTsgHP8hQwHxArpsP83VBs3Yonw2G_09Fo483swMeTkufM_aDJFuJuRk_E7JMPYf7QGS8QYAmwG
 rS_kfGQY4oBVhYeBTBUoATy27WGIcTeF3ady6Cro5rnOndAb8CcUwqYXUf9cdOXnW.FnViQJyKGm
 tW4.IhEHYi62Ki8__135bjY2qwsP8aS9FKHCmZaypo1n6Ezmk_beF9DWdWe2sBXEB5jXkb.486Zv
 RJG5XjHr5O_L4PuS._itE.tZoi6Dg0f.nqxOThSeMXg_6QV.GJivTDatW_o44IiSv19Ma_aRdMTd
 UtjfI1qEWiP0wVejG_TnNo9ssv2fTGhTN2zGdK6zeuqGES4KtljR6vuBN_SZfrbWttaUopPPKFlT
 z1grLNvcg3N1pcL88qKXq9Mrtmi7zCqAO8egUzn0Q46Q81AzKn3qAknKBS4gk26MqMWVLQxIpfaj
 BmS00V3RyvKNX5W_8b1DNYWoWBrTM_4L4gMq6Ag--
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Wed, 4 Aug 2021 15:37:46 +0000
Received: by kubenode548.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 569772e185f52fd77800840c74c39349;
          Wed, 04 Aug 2021 15:37:40 +0000 (UTC)
Date:   Wed, 04 Aug 2021 11:37:36 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: [REGRESSION?] Simultaneous writes to a reader-less, non-full pipe can
 hang
To:     linux-kernel@vger.kernel.org, dhowells@redhat.com,
        acrichton@mozilla.com
Cc:     torvalds@linux-foundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
MIME-Version: 1.0
Message-Id: <1628086770.5rn8p04n6j.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
References: <1628086770.5rn8p04n6j.none.ref@localhost>
X-Mailer: WebService/1.1.18749 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

An issue "Jobserver hangs due to full pipe" was recently reported=20
against Cargo, the Rust package manager. This was diagnosed as an issue=20
with pipe writes hanging in certain circumstances.

Specifically, if two or more threads simultaneously write to a pipe, it=20
is possible for all the writers to hang despite there being significant=20
space available in the pipe.

I have translated the Rust example to C with some small adjustments:

#define _GNU_SOURCE
#include <fcntl.h>
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

static int pipefd[2];

void *thread_start(void *arg) {
    char buf[1];
    for (int i =3D 0; i < 1000000; i++) {
        read(pipefd[0], buf, sizeof(buf));
        write(pipefd[1], buf, sizeof(buf));
    }
    puts("done");
    return NULL;
}

int main() {
    pipe(pipefd);
    printf("init buffer: %d\n", fcntl(pipefd[1], F_GETPIPE_SZ));
    printf("new buffer:  %d\n", fcntl(pipefd[1], F_SETPIPE_SZ, 0));
    write(pipefd[1], "aa", 2);
    pthread_t thread1, thread2;
    pthread_create(&thread1, NULL, thread_start, NULL);
    pthread_create(&thread2, NULL, thread_start, NULL);
    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);
}

The expected behavior of this program is to print:

init buffer: 65536
new buffer:  4096
done
done

and then exit.

On Linux 5.14-rc4, compiling this program and running it will print the=20
following about half the time:

init buffer: 65536
new buffer:  4096
done

and then hang. This is unexpected behavior, since the pipe is at most=20
two bytes full at any given time.

/proc/x/stack shows that the remaining thread is hanging at pipe.c:560.=20
It looks like not only there needs to be space in the pipe, but also=20
slots. At pipe.c:1306, a one-page pipe has only one slot. this led me to=20
test nthreads=3D2, which also hangs. Checking blame of the pipe_write=20
comment, it was added in a194dfe, which says, among other things:

> We just abandon the preallocated slot if we get a copy error.  Future
> writes may continue it and a future read will eventually recycle it.

This matches the observed behavior: in this case, there are no readers=20
on the pipe, so the abandoned slot is lost.

In my opinion (as expressed on the issue), the pipe is being misused=20
here. As explained in the pipe(7) manual page:

> Applications should not rely on a particular capacity: an application=20
> should be designed so that a reading process consumes data as soon as=20
> it is available, so that a writing process does not remain blocked.

Despite the misuse, I am reporting this for the following reasons:

1. I am reasonably confident that this is a regression in the kernel,=20
   which has a standard of making reasonable efforts to maintain=20
   backwards compatibility even with broken programs.

2. Even if this is not a regression, it seems like this situation could=20
   be handled somewhat more gracefully. In this case, we are not writing=20
   4095 bytes and then expecting a one-byte write to succeed; the pipe=20
   is actually almost entirely empty.

3. Pipe sizes dynamically shrink in Linux, so despite the fact that this=20
   case is unlikely to occur with two or more slots available, even a=20
   program which does not explicitly allocate a one-page pipe buffer may=20
   wind up with one if the user has 1024 or more pipes already open.=20
   This significantly exacerbates the next point:

4. GNU make's jobserver uses pipes in a similar manner. By my reading of=20
   the paper, it is theoretically possible for an N simultaneous writes=20
   to occur without any readers, where N is the maximum concurrent jobs=20
   permitted.

   Consider the following example with make -j2: two compile jobs are to=20
   be performed: one at the top level, and one in a sub-directory. The=20
   top-level make invokes one make and one cc, costing two tokens. The=20
   sub-make invokes one cc with its free token. The pipe is now empty.=20
   Now, suppose the two compilers return at exactly the same time. Both=20
   copies of make will attempt to simultaneously write a token to the=20
   pipe. This does not yet trigger deadlock: at least one write will=20
   always succeed on an empty pipe. Suppose the sub-make's write goes=20
   through. It then exits. The top-level make, however, is still blocked=20
   on its original write, since it was not successfully merged with the=20
   other write. The build is now deadlocked.

   I think this does not happen only by a coincidental design decision:=20
   when the sub-make exits, the top-level make receives a SIGCHLD. GNU=20
   make registers a SA_RESTART handler for SIGCHLD, so the write will be=20
   interrupted and restarted. This is only a coincidence, however: the=20
   program does not actually expect writing to the control pipe to ever=20
   block; it could just as well de-register the signal handler while=20
   performing the write and still be fully correct.

Regards,
Alex.
