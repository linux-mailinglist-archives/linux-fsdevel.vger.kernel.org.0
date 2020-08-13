Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81887243300
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 05:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgHMD4y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 23:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgHMD4x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 23:56:53 -0400
X-Greylist: delayed 195 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Aug 2020 20:56:53 PDT
Received: from sequoia-grove.ad.secure-endpoints.com (sequoia-grove.secure-endpoints.com [IPv6:2001:470:1f07:f77:70f5:c082:a96a:5685])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F536C061383
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 20:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
        d=auristor.com; s=MDaemon; r=y; t=1597290815; x=1597895615;
        i=jaltman@auristor.com; q=dns/txt; h=Subject:To:Cc:References:
        From:Organization:Message-ID:Date:User-Agent:MIME-Version:
        In-Reply-To:Content-Type; bh=f/2tRTr1rkMkK3sJkfGwbrfQnYXmjf4qRYg
        ajsFn738=; b=VQHo/vvN6e3EOThSX1H6VAUS78dZrl8IC83QKFQW0rtnZmWCdms
        x6N4sANXTlzlu00MNWdGDGpl9AMvrzVFG9pQ9FzXWFYMTqInghm6teybeia/mp2l
        KjZP62holfKQr8l8URBwM6+2NUUA8DHCG1nGjsL5NXbFYRC/zpiQaOe0=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.ad.secure-endpoints.com, Wed, 12 Aug 2020 23:53:35 -0400
Received: from [IPv6:2604:2000:1741:8407:386c:2342:327a:af43] by auristor.com (IPv6:2001:470:1f07:f77:28d9:68fb:855d:c2a5) (MDaemon PRO v20.0.1) 
        with ESMTPSA id md5001002622305.msg; Wed, 12 Aug 2020 23:53:34 -0400
X-Spam-Processed: sequoia-grove.ad.secure-endpoints.com, Wed, 12 Aug 2020 23:53:34 -0400
        (not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2604:2000:1741:8407:386c:2342:327a:af43
X-MDHelo: [IPv6:2604:2000:1741:8407:386c:2342:327a:af43]
X-MDArrival-Date: Wed, 12 Aug 2020 23:53:34 -0400
X-MDOrigin-Country: United States, North America
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=14943734bf=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-fsdevel@vger.kernel.org
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     "Linus Torvalds (torvalds@linux-foundation.org)" 
        <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1842689.1596468469@warthog.procyon.org.uk>
 <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
 <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk>
 <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
From:   Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
Message-ID: <679456f1-5867-4017-b1d6-95197d2fa81b@auristor.com>
Date:   Wed, 12 Aug 2020 23:53:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms080403000101050505020307"
X-MDCFSigsAdded: auristor.com
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms080403000101050505020307
Content-Type: multipart/mixed;
 boundary="------------3526248CBE805C34880B7D77"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------3526248CBE805C34880B7D77
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8/12/2020 2:18 PM, Linus Torvalds (torvalds@linux-foundation.org) wrot=
e:
> What's wrong with fstatfs()? All the extra magic metadata seems to not
> really be anything people really care about.
>=20
> What people are actually asking for seems to be some unique mount ID,
> and we have 16 bytes of spare information in 'struct statfs64'.
>=20
> All the other fancy fsinfo stuff seems to be "just because", and like
> complete overdesign.

Hi Linus,

Is there any existing method by which userland applications can
determine the properties of the filesystem in which a directory or file
is stored in a filesystem agnostic manner?

Over the past year I've observed the opendev/openstack community
struggle with performance issues caused by rsync's inability to
determine if the source and destination object's last update time have
the same resolution and valid time range.  If the source file system
supports 100 nanosecond granularity and the destination file system
supports one second granularity, any source file with a non-zero
fractional seconds timestamp will appear to have changed compared to the
copy in the destination filesystem which discarded the fractional
seconds during the last sync.  Sure, the end user could use the
--modify-window=3D1 option to inform rsync to add fuzz to the comparisons=
,
but that introduces the possibility that a file updated a fraction of a
second after an rsync execution would not synchronize the file on the
next run when both source and target have fine grained timestamps.  If
the userland sync processes have access to the source and destination
filesystem time capabilities, they can make more intelligent decisions
without explicit user input.  At a minimum, the timestamp properties
that are important to know include the range of valid timestamps and the
resolution.  Some filesystems support unsigned 32-bit time starting with
UNIX epoch.  Others signed 32-bit time with UNIX epoch.  Still others
FAT, NTFS, etc use alternative epochs and range and resolutions.

Another case where lack of filesystem properties is problematic is "df
--local" which currently relies upon string comparisons of file system
name strings to determine if the underlying file system is local or
remote.  This requires that the gnulib maintainers have knowledge of all
file systems implementations, their published names, and which category
they belong to.  Patches have been accepted in the past year to add
"smb3", "afs", and "gpfs" to the list of remote file systems.  There are
many more remote filesystems that have yet to be added including
"cephfs", "lustre", "gluster", etc.

In many cases, the filesystem properties cannot be inferred from the
filesystem name.  For network file systems, these properties might
depend upon the remote server capabilities or even the properties
associated with a particular volume or share.  Consider the case of a
remote file server that supports 64-bit 100ns time but which for
backward compatibility exports certain volumes or shares with more
restrictive capabilities. Or the case of a network file system protocol
that has evolved over time and gained new capabilities.

For the AFS community, fsinfo offers a method of exposing some server
and volume properties that are obtained via "path ioctls" in OpenAFS and
AuriStorFS.  Some example of properties that might be exposed include
answers to questions such as:

 * what is the volume cell id? perhaps a uuid.
 * what is the volume id in the cell? unsigned 64-bit integer
 * where is a mounted volume hosted? which fileservers, named by uuid
 * what is the block size? 1K, 4K, ...
 * how many blocks are in use or available?
 * what is the quota (thin provisioning), if any?
 * what is the reserved space (fat provisioning), if any?
 * how many vnodes are present?
 * what is the vnode count limit, if any?
 * when was the volume created and last updated?
 * what is the file size limit?
 * are byte range locks supported?
 * are mandatory locks supported?
 * how many entries can be created within a directory?
 * are cross-directory hard links supported?
 * are directories just-send-8, case-sensitive, case-preserving, or
   case-insensitive?
 * if not just-send-8, what character set is used?
 * if Unicode, what normalization rules? etc.
 * are per-object acls supported?
 * what volume maximum acl is assigned, if any?
 * what volume security policy (authn, integ, priv) is assigned, if any?
 * what is the replication policy, if any?
 * what is the volume encryption policy, if any?
 * what is the volume compression policy, if any?
 * are server-to-server copies supported?
 * which of atime, ctime and mtime does the volume support?
 * what is the permitted timestamp range and resolution?
 * are xattrs supported?
 * what is the xattr maximum name length?
 * what is the xattr maximum object size?
 * is the volume currently reachable?
 * is the volume immutable?
 * etc ...

Its true that there isn't widespread use of these filesystem properties
by today's userland applications but that might be due to the lack of
standard interfaces necessary to acquire the information.  For example,
userland frameworks for parallel i/o HPC applications such as HDF5,
PnetCDF and ROMIO require each supported filesystem to provide its own
proprietary "driver" which does little more than expose the filesystem
properties necessary to optimize the layout of file stream data
structures.  With something like "fsinfo" it would be much easier to
develop these HPC frameworks in a filesystem agnostic manner.  This
would permit applications built upon these frameworks to use the best
Linux filesystem available for the workload and not simply the ones for
which proprietary "drivers" have been published.

Although I am sympathetic to the voices in the community that would
prefer to start over with a different architectural approach, David's
fsinfo has been under development for more than two years.  It has not
been developed in a vacuum but in parallel with other kernel components
that have been merged during that time frame.  From my reading of this
thread and those that preceded it, fsinfo has also been developed with
input from significant userland development communities that intend to
leverage the syscall interface as soon as it becomes available.  The
March 2020 discussion of fsinfo received positive feedback not only from
within Red Hat but from other parties as well.

Since no one stepped up to provide an alternative approach in the last
five months, how long should those that desire access to the
functionality be expected to wait for it?

What is the likelihood that an alternative robust solution will be
available in the next merge window or two?

Is the design so horrid that it is better to go without the
functionality than to live with the imperfections?

I for one would like to see this functionality be made available sooner
rather than later.  I know my end users would benefit from the
availability of fsinfo.

Thank you for listening.  Stay healthy and safe, and please wear a mask.

Jeffrey Altman


--------------3526248CBE805C34880B7D77
Content-Type: text/x-vcard; charset=utf-8;
 name="jaltman.vcf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="jaltman.vcf"

begin:vcard
fn:Jeffrey Altman
n:Altman;Jeffrey
org:AuriStor, Inc.
adr:;;255 W 94TH ST STE 6B;New York;NY;10025-6985;United States
email;internet:jaltman@auristor.com
title:CEO
tel;work:+1-212-769-9018
url:https://www.linkedin.com/in/jeffreyaltman/
version:2.1
end:vcard


--------------3526248CBE805C34880B7D77--

--------------ms080403000101050505020307
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DGswggXSMIIEuqADAgECAhBAAW0B1qVVQ32wvx2EXYU6MA0GCSqGSIb3DQEBCwUAMDoxCzAJ
BgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEy
MB4XDTE5MDkwNTE0MzE0N1oXDTIyMTEwMTE0MzE0N1owcDEvMC0GCgmSJomT8ixkAQETH0Ew
MTQxMEMwMDAwMDE2RDAxRDZBNTQwMDAwMDQ0NDcxGTAXBgNVBAMTEEplZmZyZXkgRSBBbHRt
YW4xFTATBgNVBAoTDEF1cmlTdG9yIEluYzELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQCY1TC9QeWnUgEoJ81FcAVnhGn/AWuzvkYRUG5/ZyXDdaM212e8
ybCklgSmZweqNdrfaaHXk9vwjpvpD4YWgb07nJ1QBwlvRV/VPAaDdneIygJJWBCzaMVLttKO
0VimH/I/HUwFBQT2mrktucCEf2qogdi2P+p5nuhnhIUiyZ71Fo43gF6cuXIMV/1rBNIJDuwM
Q3H8zi6GL0p4mZFZDDKtbYq2l8+MNxFvMrYcLaJqejQNQRBuZVfv0Fq9pOGwNLAk19baIw3U
xdwx+bGpTtS63Py1/57MQ0W/ZXE/Ocnt1qoDLpJeZIuEBKgMcn5/iN9+Ro5zAuOBEKg34wBS
8QCTAgMBAAGjggKcMIICmDAOBgNVHQ8BAf8EBAMCBPAwgYQGCCsGAQUFBwEBBHgwdjAwBggr
BgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVudHJ1c3QuY29tMEIGCCsGAQUF
BzAChjZodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2NlcnRzL3RydXN0aWRjYWEx
Mi5wN2MwHwYDVR0jBBgwFoAUpHPa72k1inXMoBl7CDL4a4nkQuwwCQYDVR0TBAIwADCCASsG
A1UdIASCASIwggEeMIIBGgYLYIZIAYb5LwAGAgEwggEJMEoGCCsGAQUFBwIBFj5odHRwczov
L3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRpZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRt
bDCBugYIKwYBBQUHAgIwga0MgapUaGlzIFRydXN0SUQgQ2VydGlmaWNhdGUgaGFzIGJlZW4g
aXNzdWVkIGluIGFjY29yZGFuY2Ugd2l0aCBJZGVuVHJ1c3QncyBUcnVzdElEIENlcnRpZmlj
YXRlIFBvbGljeSBmb3VuZCBhdCBodHRwczovL3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRp
ZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRtbDBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8v
dmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2NybC90cnVzdGlkY2FhMTIuY3JsMB8GA1UdEQQY
MBaBFGphbHRtYW5AYXVyaXN0b3IuY29tMB0GA1UdDgQWBBR7pHsvL4H5GdzNToI9e5BuzV19
bzAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAFlm
JYk4Ff1v/n0foZkv661W4LCRtroBaVykOXetrDDOQNK2N6JdTa146uIZVgBeU+S/0DLvJBKY
tkUHQ9ovjXJTsuCBmhIIw3YlHoFxbku0wHEpXMdFUHV3tUodFJJKF3MbC8j7dOMkag59/Mdz
Sjszdvit0av9nTxWs/tRKKtSQQlxtH34TouIke2UgP/Nn901QLOrJYJmtjzVz8DW3IYVxfci
SBHhbhJTdley5cuEzphELo5NR4gFjBNlxH7G57Hno9+EWILpx302FJMwTgodIBJbXLbPMHou
xQbOL2anOTUMKO8oH0QdQHCtC7hpgoQa7UJYJxDBI+PRaQ/HObkwggaRMIIEeaADAgECAhEA
+d5Wf8lNDHdw+WAbUtoVOzANBgkqhkiG9w0BAQsFADBKMQswCQYDVQQGEwJVUzESMBAGA1UE
ChMJSWRlblRydXN0MScwJQYDVQQDEx5JZGVuVHJ1c3QgQ29tbWVyY2lhbCBSb290IENBIDEw
HhcNMTUwMjE4MjIyNTE5WhcNMjMwMjE4MjIyNTE5WjA6MQswCQYDVQQGEwJVUzESMBAGA1UE
ChMJSWRlblRydXN0MRcwFQYDVQQDEw5UcnVzdElEIENBIEExMjCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBANGRTTzPCic0kq5L6ZrUJWt5LE/n6tbPXPhGt2Egv7plJMoEpvVJ
JDqGqDYymaAsd8Hn9ZMAuKUEFdlx5PgCkfu7jL5zgiMNnAFVD9PyrsuF+poqmlxhlQ06sFY2
hbhQkVVQ00KCNgUzKcBUIvjv04w+fhNPkwGW5M7Ae5K5OGFGwOoRck9GG6MUVKvTNkBw2/vN
MOd29VGVTtR0tjH5PS5yDXss48Yl1P4hDStO2L4wTsW2P37QGD27//XGN8K6amWB6F2XOgff
/PmlQjQOORT95PmLkwwvma5nj0AS0CVp8kv0K2RHV7GonllKpFDMT0CkxMQKwoj+tWEWJTiD
KSsCAwEAAaOCAoAwggJ8MIGJBggrBgEFBQcBAQR9MHswMAYIKwYBBQUHMAGGJGh0dHA6Ly9j
b21tZXJjaWFsLm9jc3AuaWRlbnRydXN0LmNvbTBHBggrBgEFBQcwAoY7aHR0cDovL3ZhbGlk
YXRpb24uaWRlbnRydXN0LmNvbS9yb290cy9jb21tZXJjaWFscm9vdGNhMS5wN2MwHwYDVR0j
BBgwFoAU7UQZwNPwBovupHu+QucmVMiONnYwDwYDVR0TAQH/BAUwAwEB/zCCASAGA1UdIASC
ARcwggETMIIBDwYEVR0gADCCAQUwggEBBggrBgEFBQcCAjCB9DBFFj5odHRwczovL3NlY3Vy
ZS5pZGVudHJ1c3QuY29tL2NlcnRpZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRtbDADAgEB
GoGqVGhpcyBUcnVzdElEIENlcnRpZmljYXRlIGhhcyBiZWVuIGlzc3VlZCBpbiBhY2NvcmRh
bmNlIHdpdGggSWRlblRydXN0J3MgVHJ1c3RJRCBDZXJ0aWZpY2F0ZSBQb2xpY3kgZm91bmQg
YXQgaHR0cHM6Ly9zZWN1cmUuaWRlbnRydXN0LmNvbS9jZXJ0aWZpY2F0ZXMvcG9saWN5L3Rz
L2luZGV4Lmh0bWwwSgYDVR0fBEMwQTA/oD2gO4Y5aHR0cDovL3ZhbGlkYXRpb24uaWRlbnRy
dXN0LmNvbS9jcmwvY29tbWVyY2lhbHJvb3RjYTEuY3JsMB0GA1UdJQQWMBQGCCsGAQUFBwMC
BggrBgEFBQcDBDAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0OBBYEFKRz2u9pNYp1zKAZewgy+GuJ
5ELsMA0GCSqGSIb3DQEBCwUAA4ICAQAN4YKu0vv062MZfg+xMSNUXYKvHwvZIk+6H1pUmivy
DI4I6A3wWzxlr83ZJm0oGIF6PBsbgKJ/fhyyIzb+vAYFJmyI8I/0mGlc+nIQNuV2XY8cypPo
VJKgpnzp/7cECXkX8R4NyPtEn8KecbNdGBdEaG4a7AkZ3ujlJofZqYdHxN29tZPdDlZ8fR36
/mAFeCEq0wOtOOc0Eyhs29+9MIZYjyxaPoTS+l8xLcuYX3RWlirRyH6RPfeAi5kySOEhG1qu
NHe06QIwpigjyFT6v/vRqoIBr7WpDOSt1VzXPVbSj1PcWBgkwyGKHlQUOuSbHbHcjOD8w8wH
SDbL+L2he8hNN54doy1e1wJHKmnfb0uBAeISoxRbJnMMWvgAlH5FVrQWlgajeH/6NbYbBSRx
ALuEOqEQepmJM6qz4oD2sxdq4GMN5adAdYEswkY/o0bRKyFXTD3mdqeRXce0jYQbWm7oapqS
ZBccFvUgYOrB78tB6c1bxIgaQKRShtWR1zMM0JfqUfD9u8Fg7G5SVO0IG/GcxkSvZeRjhYcb
TfqF2eAgprpyzLWmdr0mou3bv1Sq4OuBhmTQCnqxAXr4yVTRYHkp5lCvRgeJAme1OTVpVPth
/O7HJ7VuEP9GOr6kCXCXmjB4P3UJ2oU0NqfoQdcSSSt9hliALnExTEjii20B2nSDojGCAxQw
ggMQAgEBME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUGA1UEAxMO
VHJ1c3RJRCBDQSBBMTICEEABbQHWpVVDfbC/HYRdhTowDQYJYIZIAWUDBAIBBQCgggGXMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIwMDgxMzAzNTMyN1ow
LwYJKoZIhvcNAQkEMSIEIEBk6RtolrAjcAhdqSia+2IVgAkurgTuWSaqerOmZQzvMF0GCSsG
AQQBgjcQBDFQME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUGA1UE
AxMOVHJ1c3RJRCBDQSBBMTICEEABbQHWpVVDfbC/HYRdhTowXwYLKoZIhvcNAQkQAgsxUKBO
MDoxCzAJBgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQg
Q0EgQTEyAhBAAW0B1qVVQ32wvx2EXYU6MGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEAiKGKE6jKQ8Wz
3ISR4ZZtZqR1bxSxg0bAl1P4PSlw+h2yJvHIpU/edNGag4gxbtfgcmxDfbDB9s+jyS+kTaZK
1WKGvYLvBMVuMjO+A2Xn8IxibQRDtH8Ptou5bo7m3UMArRe5mV8u0ruQVDa0K1AleWj+p1rC
B15Uw4x+UKaNOjhVNxH2XQ4ys0X08aBDIn6fbJ92KqHvNnU66Qn5UC0IZt9LpcET4iMcyjkw
rZ/f0K6X5mWS6AKDQ1biXqI9x8h1daTqKwIW6oMjF8sVQcmHnzbOn7bQxRWpYw6ET9Io1DrQ
i+igEqJK5JBRBPF7+aa1FqPGtbN/GTpiCSn3FgzGmAAAAAAAAA==
--------------ms080403000101050505020307--

